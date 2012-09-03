require 'spec_helper'

describe "SectionAssignments" do
  describe "POST /section_assignments.xml" do
    it "creates a section_assignment" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
			course = Fabricate :course, number: 321
			teacher = Fabricate :teacher, login: 'davidsonl'
			Fabricate :section, teacher: teacher, course: course, block: 'D', academic_year: 2013
			Fabricate :assignment, assgt_id: 614637
			
			hash = {
				'teacher_id' => 'davidsonl',
				'academic_year' => '2013',
				'course_num' => '321',
				'block' => 'D',
				'due_date' => '2012-09-18',
				'name' => 'testing',
				'use_assgt' => 'Y',
				'assgt_id' => '614637'
			}
      xhr :post, 'section_assignments.xml', {'section_assignment' => hash}
      response.status.should eql(200)
    end
  end

end
