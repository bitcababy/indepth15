# encoding: UTF-8

require 'spec_helper'

describe Assignment do
  it { should have_many :section_assignments }
  it { should accept_nested_attributes_for :section_assignments }
  it { should belong_to :teacher }
  it { should have_and_belong_to_many :major_topics }
  
  specify { subject.minor_topics.should be_kind_of SortedSet }

	context "Fabricator" do
    it "creates a useful assignment" do
      asst = Fabricate :assignment
      asst.content.should_not be_nil
    end
    it "adds itself to the course assignments if there's a course" do
      course = Fabricate :course
      asst = Fabricate :assignment, course: course
      asst.course.should eq course
      course.assignments.should contain asst
    end
    it "adds itself to the teacher's assignments if there's a teacher" do
      teacher = Fabricate :teacher
      asst = Fabricate :assignment, teacher: teacher
      asst.teacher.should eq teacher
      teacher.assignments.should contain asst
    end
	end

  describe '#set_course_and_teacher' do
    it "sets the course and teacher from the section"
  end
end
