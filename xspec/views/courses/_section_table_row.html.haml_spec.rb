require 'spec_helper'

describe 'courses/_section_table_row' do
  before do
    view.stub(:assignments_pane_section_path).and_return ""
  end

  it "displays a row for a section" do
    teacher = mock_model Teacher, formal_name: "Mr. Ed"
    section = mock_model Section, block: "B", teacher: teacher, room: "500"
      
    render partial: 'courses/section_table_row', locals: {section: section}
    expect(page).to have_selector('tr')
    row = page.find('tr')
    expect(row).to have_selector('td.block', text: "B")
    expect(row).to have_selector('td.teacher', text: "Mr. Ed")
    expect(row).to have_selector('td.room', text: "5")
  end
	
end
