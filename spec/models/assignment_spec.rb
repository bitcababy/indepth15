# encoding: UTF-8

require 'spec_helper'

describe Assignment do
  it { should have_many :section_assignments }
  it { should accept_nested_attributes_for :section_assignments }
  it { should have_and_belong_to_many :major_topics }
  
	context "Fabricator" do
    it "creates a valid assignment" do
      asst = Fabricate :assignment
      expect(asst).to be_valid
      expect(asst.content).to_not be_nil
    end
 	end
  
   describe '#course' do
    it "returns the course for this assignment" do
      c = Fabricate :course
      s = Fabricate :section, course: c
      a = Fabricate :assignment
      sa = Fabricate :section_assignment, section: s, assignment: a
      expect(a.course).to eq c
    end
  end
      
  describe '#teacher' do
    it "returns the course for this assignment" do
      t = Fabricate :teacher
      s = Fabricate :section, teacher: t
      a = Fabricate :assignment
      sa = Fabricate :section_assignment, section: s, assignment: a
      expect(a.teacher).to eq t
    end
  end
  
end
