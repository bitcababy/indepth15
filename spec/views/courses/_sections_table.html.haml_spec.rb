require 'spec_helper'

describe 'courses/_sections_table' do
	include CourseMockHelpers

  it "creates a table of a courses sections" do
    course = mock_course_with_sections
    stub_template 'courses/_section_table_row' => "A row"
    render partial: 'courses/sections_table', locals: {course: course}
    expect(rendered).to have_selector('table#sections_table thead tr') do |row|
      %W(block teacher room).each do |hdr|
        expect(row).to have_selector('th', class: hdr)
      end
    end
  end
		
end


	