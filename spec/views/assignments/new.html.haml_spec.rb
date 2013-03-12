require 'spec_helper'

describe 'assignments/new' do
  before :each do
    teacher = Fabricate :teacher, login: "xyzzy"
    course = Fabricate :course
    course.major_topics = [
      Fabricate(:major_topic, name: "Sequence"),
      Fabricate(:major_topic, name: "Exponentials"),
    ]
    sections = (0..2).collect {|i| 
      Fabricate :section, teacher: teacher, course: course, year: Settings.academic_year, block: ('A'..'H').to_a[i]
    }
    assignment = Fabricate.build :assignment
    @sas = sections.collect {|section| Fabricate :section_assignment, section: section}
    assign(:course, course)
    assign(:assignment, assignment)
    assign(:sas, @sas)
    render
  end
  
  it "displays a form" do
    expect(response).to have_selector('form')
  end

  it "should have fields for the block, due date, and assigned status of each section assignment" do
    pending "unfinished test"
    @sas.each do |sa|
      expect(response).to have_selector('input', value: sa.block)
    end
  end


  # before :each do
  #   section1 = Fabricate :section, block: "A"
  #   section2 = Fabricate :section, block: "B"
  #   
  #   assignment = Assignment.new
  #    
  #   sa1 = Fabricate :section_assignment, section: section1, due_date: Date.today, assigned: true
  #   expect(sa1.block).to eq 'A'
  #   sa2 = Fabricate :section_assignment, section: section2, due_date: Date.today, assigned: true
  #   assignment.stub(:section_assignments).and_return [sa1,sa2]
  #   expect(assignment.section_assignments.count).to eq 2
  #   expect(assignment.section_assignments.first.block).to eq 'A'
  #   assign(:assignment, assignment)
  #   render
  # end
  # 
  # it "displays a form" do
  #   expect(rendered).to have_selector('form')
  # end
  # 
  # context 'inputs' do
  #   it "displays an editor for the assignment" do
  #     expect(rendered).to have_selector('form') do |form|
  #       expect(form).to have_selector('textarea', name: 'assignment[content]')
  #     end
  #   end
  # 
  #   it "allows setting the due date and assigned status for each section_assignment" do
  #     expect(rendered).to have_selector('form') do |form|
  #       expect(form).to have_selector('#assignment_section_assignments_attributes_0_block', value: 'A')
  #       expect(form).to have_selector('#assignment_section_assignments_attributes_1_block', value: 'B')
  #       expect(form).to have_selector('#assignment_section_assignments_attributes_0_due_date')
  #       expect(form).to have_selector('#assignment_section_assignments_attributes_1_due_date')
  #     end
  #   end 
  # end
  # 
  # context 'buttons' do
  #   it "should have a create button" do
  #     expect(rendered).to have_selector('form') do |form|
  #       expect(form).to have_selector('input', class: 'btn', label: 'Create')
  #     end
  #   end
  #   it "should have a cancel button" do
  #     expect(rendered).to have_selector('form') do |form|
  #       expect(form).to have_selector('input', class: 'btn', label: 'Cancel')
  #     end
  #   end
  # 
  #   it "should have a reset button" do
  #     expect(rendered).to have_selector('form') do |form|
  #       expect(form).to have_selector('input', class: 'btn', label: 'Reset')
  #     end
  #   end
  # end
    
    
end
