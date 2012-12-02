require 'spec_helper'

describe 'assignments/new' do
  before :each do
    section1 = Fabricate :section, block: "A"
    section2 = Fabricate :section, block: "B"
    
    assignment = Assignment.new
     
    sa1 = Fabricate :section_assignment, section: section1, due_date: Date.today, use: true
    sa1.block.should == 'A'
    sa2 = Fabricate :section_assignment, section: section2, due_date: Date.today, use: true
    assignment.stubs(:section_assignments).returns [sa1,sa2]
    assignment.section_assignments.count.should == 2
    assignment.section_assignments.first.block.should == 'A'
    assign(:assignment, assignment)
    render
  end
  
  it "displays a form" do
    rendered.should have_selector('form')
  end
  
  context 'inputs' do
    it "displays an editor for the assignment" do
      rendered.should have_selector('form') do |form|
        form.should have_selector('textarea')
        pending
      end
    end
  
    it "allows setting the due date and use for each section_assignment" do
      rendered.should have_selector('form') do |form|
        form.should have_selector('#assignment_section_assignments_attributes_0_block', value: 'A')
        form.should have_selector('#assignment_section_assignments_attributes_1_block', value: 'B')
        form.should have_selector('#assignment_section_assignments_attributes_0_due_date')
        form.should have_selector('#assignment_section_assignments_attributes_1_due_date')
      end
    end
  end
  
  context 'buttons' do
    it "should have a create button"
    it "should have a cancel button"
    it "should have a reset button"
  end
    
    
end
