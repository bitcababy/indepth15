require 'spec_helper'

describe 'courses/_sections_table' do
	include CourseMockHelpers

	it "creates a table of a courses sections" do
		course = mock_course_with_sections
		[:full_name, :description, :credits, :duration, :number].each {|k| course.unstub(k)}

		assign(:course, course)
		render partial: 'courses/sections_table'
		rendered.should have_selector('table#sections_table thead tr') do |row|
			%W(block days teacher room).each do |hdr|
				row.should have_selector('th', class: hdr)
			end
		end
	end
		
end


	