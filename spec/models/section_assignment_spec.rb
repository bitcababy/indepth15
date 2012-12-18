require 'spec_helper'

describe SectionAssignment do
	it { should belong_to :section }
	it { should belong_to :assignment }
  # it { should accept_nested_attributes_for :section }
  it { should respond_to :block }
	
	context "scoping and delegation" do
		before :each do
			@section = Fabricate :section, block: "B"
			3.times {|i| Fabricate :future_section_assignment, section: @section }
			4.times {|i| Fabricate :past_section_assignment, section: @section }
		end
    
    it "should be able to get its block from its section" do
      sa = Fabricate :section_assignment, section: @section
      sa.block.should == "B"
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
	

end
