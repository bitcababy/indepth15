# encoding: UTF-8

require 'spec_helper'

describe Assignment do
  it { should have_many :section_assignments }
  it { should accept_nested_attributes_for :section_assignments }
  it { should belong_to :teacher }
  it { should have_and_belong_to_many :major_topics }
  
	context "Fabricator" do
    it "creates a valid assignment" do
      asst = Fabricate :assignment
      expect(asst).to be_valid
      expect(asst.content).to_not be_nil
    end
    it "adds itself to the course assignments if there's a course" do
      course = Fabricate :course
      asst = Fabricate :assignment, course: course
      expect(asst.course).to eq course
      expect(course.assignments).to contain asst
    end
    it "adds itself to the teacher's assignments if there's a teacher" do
      teacher = Fabricate :teacher
      asst = Fabricate :assignment, teacher: teacher
      expect(asst.teacher).to eq teacher
      expect(teacher.assignments).to contain asst
    end
	end
  
  subject { Fabricate :assignment }

  # specify { expect(subject.minor_topics).to be_kind_of SortedSet }
  
end
