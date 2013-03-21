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
  
end
