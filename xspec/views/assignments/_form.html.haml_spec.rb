require 'spec_helper'

describe 'assignments/_form' do
  include DueDate
  include CapybaraExtras

  def sas_to_rows(sas)
    return sas.collect do |sa|
      [sa.block, sa.due_date, sa.assigned]
    end
  end

  before :each do
    teacher = Fabricate :teacher
    course = Fabricate :course, num_sections: 3, teacher: teacher
    @assignment = Fabricate.build :assignment
    dd = next_school_day
    for section in course.sections do
      @assignment.section_assignments.build section: section, due_date: dd
    end
  
  	render partial: 'assignments/form', as: :assignment, object: @assignment, locals: {method: 'post'}
  end
  
  it "displays a form" do
    expect(rendered).to have_selector('#asst_form form')
    form = page.find('#asst_form form')
    expect(form).to have_table('sas')
    table = form.find('table#sas')
    expect(table_headers(table)).to eq ['Block', 'Due date', 'Use?']
    pending "unfinished test"
    cells =  + sas_to_rows(@assignment.section_assignments)
    expect(table_to_array(table)).to eq cells
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
