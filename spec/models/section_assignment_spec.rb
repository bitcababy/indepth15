require 'spec_helper'

describe SectionAssignment do
	it { should belong_to :section }
	it { should belong_to :assignment }
	
	context "scoping" do
		before :each do
			@section = Fabricate(:section)
			3.times {|i| Fabricate :future_section_assignment, section: @section }
			4.times {|i| Fabricate :past_section_assignment, section: @section }
		end
		
		it "has a for_section scope" do
			SectionAssignment.for_section(@section).to_a.count.should == 7
		end
		
		it "has a future scope" do
			SectionAssignment.for_section(@section).future.to_a.count.should == 3
		end
		
		it "has a past scope" do
			SectionAssignment.past.to_a.count.should == 4
		end
		
		it "has a next_assignment scope" do
			SectionAssignment.next_assignment.to_a.count.should == 1
		end

		it "has an upcoming scope" do
			SectionAssignment.upcoming.to_a.count.should == 2
		end
		
	end
	
	# context "incoming" do
	# 	describe '::handle_incoming' do
	# 		before :each do
	# 			course = Fabricate :course, number: 321
	# 			Fabricate :assignment, assgt_id: 614639
	# 			teacher = Fabricate :teacher, login: 'davidsonl'
	# 			@section = Fabricate :section, academic_year: 2013, block: "D", course: course, teacher: teacher
	# 
	# 			@hash = {:teacher_id=>"davidsonl", 
	# 				:year=>"2013", 
	# 				:course_num=>"321",
	# 				:block=>"D", 
	# 				:due_date=>"2012-09-06", 
	# 				:name=>"1", 
	# 				:use_assgt=>"Y", 
	# 				:assgt_id =>"614639", 
	# 				:ada=>"2012-08-19 18:34:40", 
	# 				:aa=>"2012-08-19 18:37:16"
	# 			}
	# 		end
	# 		it "creates a new section_assignment if the assgt_id is new" do
	# 			expect {
	# 				SectionAssignment.handle_incoming @hash
	# 			}.to change(@section.section_assignments, :count).by(1)
	# 		end
	# 		it "updates an section_assignment if the assgt_id is old" do
	# 			SectionAssignment.handle_incoming @hash
	# 			expect {
	# 				SectionAssignment.handle_incoming @hash
	# 			}.to change(@section.section_assignments, :count).by(0)
	# 		end
	# 	end
	# end
	

	describe 'SectionAssignment.import_from_hash' do
		before :each do
			@hash = {
				:teacher_id=>"davidsonl", 
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
			course = Fabricate :course, number: @hash[:course_num]
			Fabricate :assignment, assgt_id: @hash[:assgt_id]
			teacher = Fabricate :teacher, login: @hash[:teacher_id]
			@section = Fabricate :section, academic_year: @hash[:year].to_i, block: @hash[:block], course: course, teacher: teacher

		end

		it "should create a SectionAssignment if it's new" do
			sa = SectionAssignment.import_from_hash(Hash[@hash])
			sa.should be_kind_of SectionAssignment
		end
		
		it "should update a SectionAssignment if it's old" do
			SectionAssignment.import_from_hash(Hash[@hash])
			@hash[:due_date] = "2012-09-07"
			expect {
				SectionAssignment.import_from_hash(Hash[@hash])
			}.to change(@section.section_assignments.to_a, :count).by(0)
			@hash[:due_date] = "2012-09-08"
			sa = SectionAssignment.import_from_hash(Hash[@hash])
			sa.should be_kind_of SectionAssignment
			sa.due_date.should == Date.new(2012, 9, 8)
		end
			
	end
		
end
