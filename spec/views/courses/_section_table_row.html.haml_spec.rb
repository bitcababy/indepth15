require 'spec_helper'

describe 'courses/_section_table_row' do
	include CourseMockHelpers
	
	it "displays a row for a section" do
		teacher = mock_teacher(formal_name: "Mr. Ed")
		section = mock_section(block: "B", days_for_section: [1,2,3,4,5], room: "501", teacher: teacher)

		render partial: 'courses/section_table_row', locals: {section: section}
		rendered.should have_selector('tr') do |row|
			row.should have_selector('td.block', content: "B")
			row.should have_selector('td.days', content: "12345")
			row.should have_selector('td.teacher', content: "Mr. Ed")
			row.should have_selector('td.room', content: "5")
		end
	end
	
end
