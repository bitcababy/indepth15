# encoding: UTF-8

require 'spec_helper'

describe "courses/_sections_pane" do
	include CourseMockHelpers

	it "display a pane with the sections of a course" do
    view.stubs(:assignments_page_path).returns "foo"
		course = mock_course_with_sections(6)
		assign(:course, course)
	
		course.stubs(:number).returns 321
		course.stubs(:duration).returns Course::FULL_YEAR
		course.stubs(:credits).returns 5.0
		t = mock_text_doc("Some description")
		course.stubs(:description).returns t
		render partial: "courses/sections_pane", locals: {course: course}
		rendered.should have_selector('div#sections_pane') do |div|
			div.should contain('Course 321 — Full Year ')
			div.should contain("Some description")
			div.should contain("In the #{academic_year_string(Settings.academic_year)} academic year there are 6 sections of Fractals 101.")
		end
	end
	
end
