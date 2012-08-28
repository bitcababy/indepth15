require 'spec_helper'

describe SectionAssignment do
	it { should be_embedded_in :section }
	it { should belong_to :assignment }
	
	context "scoping" do
		before :each do
			@section = Fabricate(:section)
			4.times {|i| @section.add_assignment Fabricate(:assignment), Date.today + i + 1 }
			3.times {|i| @section.add_assignment Fabricate(:assignment), Date.today - i - 1 }
		end
		
		it "has a current scope" do
			@section.section_assignments.current.count.should == 1
		end
		
		it "has a future scope" do
			@section.section_assignments.future.count.should == 4
		end
		
		it "has a past scope" do
			@section.section_assignments.past.count.should == 3
		end
		
		it "has an upcoming scope" do
			@section.section_assignments.upcoming.count.should == 3
		end
			
	end
	
	context "incoming" do
		describe '::handle_incoming' do
			before :each do
				course = Fabricate :course, number: 321
				Fabricate :assignment, assgt_id: 614639
				teacher = Fabricate :teacher, login: 'davidsonl'
				@section = Fabricate :section, academic_year: 2013, block: "D", course: course, teacher: teacher

				@hash = {:teacher_id=>"davidsonl", 
					:year=>"2013", 
					:course_num=>"321",
					:block=>"D", 
					:due_date=>"2012-09-06", 
					:name=>"1", 
					:use_assgt=>"Y", 
					:assgt_id =>"614639", 
					:ada=>"2012-08-19 18:34:40", 
					:aa=>"2012-08-19 18:37:16"
				}
			end
			it "creates a new section_assignment if the assgt_id is new" do
				expect {
					SectionAssignment.handle_incoming @hash
				}.to change(@section.section_assignments, :count).by(1)
			end
			it "updates an section_assignment if the assgt_id is old" do
				SectionAssignment.handle_incoming @hash
				expect {
					SectionAssignment.handle_incoming @hash
				}.to change(@section.section_assignments, :count).by(0)
			end
		end
	end
	

	describe 'SectionAssignment.import_from_hash' do
		it "should create a SectionAssignment" do
			asst = Fabricate :assignment, assgt_id: 1234, content: "foo"
			Assignment.where(assgt_id: 1234).count.should == 1
			teacher = Fabricate(:teacher, login: 'greenx')
			teacher.should_not be_nil
			course = Fabricate(:course, number: 567, full_name: 'Math 101')
			course.should_not be_nil
			section = Fabricate(:section, teacher: teacher, course: course, block: "C", academic_year: 2012)
			section.should_not be_nil
			sa = SectionAssignment.import_from_hash({
				assgt_id: 1234,
				course_num: 567,
				use_assgt: 'Y',
				block: "C",
				year: 2012,
				teacher_id: 'greenx',
			})
			sa.should be_kind_of SectionAssignment
		end
		
	end
		
end
