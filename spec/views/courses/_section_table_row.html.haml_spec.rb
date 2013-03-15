require 'spec_helper'

describe 'courses/_section_table_row' do
  before do
    view.stubs(:assignments_pane_section_path).returns ""
  end
  it "displays a row for a section" do
    teacher = mock('teacher') do
      stubs(:formal_name).returns "Mr. Ed"
    end
    section = mock('section') do
      stubs(:block).returns "B"
      stubs(:teacher).returns teacher
      stubs(:room).returns "500"
    end
      
    render partial: 'courses/section_table_row', locals: {section: section}
  
    expect(rendered).to have_selector('tr')
    expect(rendered).to have_selector('td.block', text: "B")
    expect(rendered).to have_selector('td.teacher', text: "Mr. Ed")
    expect(rendered).to have_selector('td.room', text: "5")
  end
	
end
