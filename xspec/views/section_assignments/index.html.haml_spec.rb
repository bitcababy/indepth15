require 'spec_helper'

describe 'section_assignments/index' do
  it "displays a table" do
    render
    expect(page).to have_table('sa-browser')
  end
  it "displays headers" do
    render
    table = page.find('table#sa-browser')
    expect(table.all('th').collect {|th| th.text }).to eq ["Year", 'Course', 'Teacher', 'Block', 'Date due', 'Name', 'Assignment']
  end
    
end
