# encoding: UTF-8

require 'spec_helper'

describe Assignment do
  it { should have_many :section_assignments }
  it { should accept_nested_attributes_for :section_assignments }
  it { should belong_to :teacher }
  it { should have_and_belong_to_many :major_topics }
  it { should have_many :browser_records }
  
  specify { subject.minor_topics.should be_kind_of SortedSet }

	context "Fabricator" do
		subject { Fabricate(:assignment) }
		specify { subject.content.should_not be_nil }
	end

  describe '#course' do
    it "returns the course it belong to" do
      t = Fabricate :teacher
      c = Fabricate :course
      s = Fabricate :section, teacher: t, course: c
      a = Fabricate :assignment
      sa = Fabricate :section_assignment, section: s, assignment: a
      sa.course.should eq c
    end
  end
  
  describe '#update_asst_number' do
    it "updates the asst_number for its teacher/course" do
      t = Fabricate :teacher
      c = Fabricate :course
      s = Fabricate :section, teacher: t, course: c
      a = Fabricate.build :assignment, name: "10"
      a.section_assignments.new section: s, due_date: Date.today
      a.save
      t.asst_numbers.find_by(course: c).number.should eq 10
    end
  end
  
end
