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
			row.should have_selector('td.block') do |cell|
				cell.should contain(@section.block)
			end
			row.should have_selector('td.days') do |cell|
				cell.should contain(@section.days_for_section.join(''))
			end
			row.should have_selector('td.teacher') do |cell|
				cell.should contain(@section.teacher.formal_name)
			end
			row.should have_selector('td.room') do |cell|
				cell.should contain(@section.room)
			end

		end
	end
	
end

