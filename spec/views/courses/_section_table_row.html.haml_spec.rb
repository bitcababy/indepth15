require 'spec_helper'

describe 'courses/_section_table_row' do
	include CourseExamplesHelper
	
	before :each do
		@section = section_with_assignments
		create_occurrences(@section)
	end

	it "displays a row for a section" do
		render partial: 'courses/section_table_row', locals: {section: @section}
		rendered.should have_selector('tr') do |row|
			row.should have_selector('td.block', content: @section.block)
			row.should have_selector('td.days', content: @section.days_for_section.join(''))
			row.should have_selector('td.teacher', content: @section.teacher.formal_name)
			row.should have_selector('td.room', content: @section.room)
		end
	end
	
end

