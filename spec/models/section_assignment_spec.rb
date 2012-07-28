require 'spec_helper'

describe SectionAssignment do
	it { should be_embedded_in :section }
	it { should belong_to :assignment }
	
	it "should have future and past scopes" do
		section = Fabricate(:section)
		2.times { section.add_assignment Fabricate(:assignment), Date.today + rand(1..5) }
		3.times { section.add_assignment Fabricate(:assignment), Date.today - rand(1..5) }
		section.section_assignments.future.count.should == 2
		section.section_assignments.past.count.should == 3
	end

	describe 'SectionAssignment.import_from_hash' do
		before :each do
			@asst = Fabricate(:assignment, assgt_id: 1234)
			Assignment.where(assgt_id: 1234).should exist
			@teacher = Fabricate(:teacher, login: 'greenx')
			Teacher.where(login: 'greenx' ).should exist
			@course = Fabricate(:course, number: 567, full_name: 'Math 101')
			Course.where(number: 567).should exist
			@section = Fabricate(:section, teacher: @teacher, course: @course, block: "C", academic_year: 2012)
			@section.should_not be_nil
			sa = SectionAssignment.import_from_hash({
				assgt_id: 1234,
				course_num: 567,
				use_assgt: 'Y',
				block: "C",
				schoolyear: 2012,
				teacher_id: 'greenx',
			})
			sa.should be_kind_of SectionAssignment
		end
		
	end
		
end
