# encoding: UTF-8

require 'spec_helper'

describe "courses/sections_pane" do
	include CourseMockHelpers

	it "display a pane with the sections of a course" do
		course = mock_course_with_sections(6)
		assign(:course, course)
	
		[:credits, :duration, :number].each {|k| course.unstub(k)}
		course.stubs(:number).returns 321
		course.stubs(:duration).returns Course::FULL_YEAR
		course.stubs(:credits).returns 5.0
		course.unstub(:description)
		t = mock_text_doc("Some description")
		course.stubs(:description).returns t
		render
		rendered.should have_selector('div#sections_pane') do |div|
			div.should have_selector('div#info', content: 'Course 321 — Full Year — 5.0 Credits')
			div.should have_selector('div#description', content: "Some description")
			div.should have_selector('div#leadin', content: "In the #{Settings.academic_year-1}—#{Settings.academic_year} academic year there are 6 sections of Fractals 101.")
		end
	end
	
end
