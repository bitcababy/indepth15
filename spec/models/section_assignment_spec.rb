require 'spec_helper'

describe SectionAssignment do
	it { should belong_to :section }
	it { should belong_to :assignment }
	
	it "should have future and past scopes" do
		section = Fabricate(:section)
		2.times { section.add_assignment Date.today + rand(1..5), Fabricate(:assignment) }
		3.times { section.add_assignment Date.today - rand(1..5), Fabricate(:assignment) }
		section.section_assignments.future.count.should == 2
		section.section_assignments.past.count.should == 3
	end

	# context "importing" do
	# 	describe '::convert_record' do
	# 		before :each do
	# 			Import::Teacher.load_from_data
	# 			Import::Course.load_from_data
	# 			Import::Assignment.load_from_data
	# 			Import::Section.load_from_data
	# 			@hash = {
	# 				'assgt_id' => 608985,
	# 				'block' => "B",
	# 				'course_num' => 336,
	# 				'deleted' => 'N',
	# 				'due_date' => '2009-09-04',
	# 				'use_assgt' => 'Y',
	# 				'schoolyear' => '2010',
	# 				'teacher_id' => 'gabrinerd',
	# 			}
	# 			@sa = SectionAssignment.convert_record(@hash)
	#  		end
	# 
	# 		it "should be linked to a section" do
	# 			@sa.section.should_not be_nil
	# 		end
	# 		it "should be linked to a section" do
	# 			@sa.assignment.should_not be_nil
	# 		end
	# 	end
	# 
	# end

end
