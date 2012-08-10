# encoding: UTF-8

require 'spec_helper'

describe "sections/assignments" do
	include CourseMockHelpers
	
	before :each do
		teacher = mock('Mr. Ed') do
			stubs(:generic_msg).returns "This is my generic message"
			stubs(:current_msg).returns "This is my current message"
			stubs(:upcoming_msg).returns "This is my upcoming message"
			stubs(:formal_name).returns "Mr. Ed"
		end
		course = mock_course(number: 321, full_name: "Fractals 101")
		@section = mock_section_with_assignments(course: course, teacher: teacher)
		@section.stubs(:page_header).returns "Page header"
		assign(:section, @section)
	end

	it "displays the teacher's generic message" do
		render
		rendered.should have_selector('div#generic-msg', content: "This is my generic message")
	end
	
	it "displays 'Current assignment'" do
		render
		rendered.should have_selector('div.title', content: 'Current assignment')
	end
	
	it "display the teacher's current assignment message and a table for the current message if there is one" do
		render
		rendered.should have_selector('div#current-msg', content: 'This is my current message')
		rendered.should have_selector('table#current')
	end

	it "skips displaying the teacher's current assignment message and the table for the current message if there isn't one" do
		# @section.current_assignment.unstub(:assignment)
		@section.unstub(:current_assignment)
		@section.stubs(:current_assignment).returns []
		render
		rendered.should_not have_selector('div#current-msg', content: 'This is my current message')
		rendered.should_not have_selector('table#current')
	end
		
end
