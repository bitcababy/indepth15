# encoding: UTF-8

require 'spec_helper'

describe "sections/assignments" do
	include CourseMockHelpers
	
	before :each do
		teacher = mock do
			stubs(:generic_msg).returns "This is my generic message"
			stubs(:current_msg).returns "This is my current message"
			stubs(:upcoming_msg).returns "This is my upcoming message"
			stubs(:formal_name).returns "Mr. Ed"
		end
		course = mock do
			stubs(:full_name).returns "Fractals 101"
		end
		@section = mock do
			stubs(:teacher).returns teacher
			stubs(:course).returns course
			stubs(:block).returns "A"
			stubs(:current_assignment).returns mock_assignments(1)
			stubs(:upcoming_assignments).returns mock_assignments(2)
			stubs(:past_assignments).returns mock_assignments(3)
			stubs(:page_header).returns "Mr.Ed's assignments for 'Fractals 101', block A "
		end
		assign(:section, @section)
	end

	it "displays the teacher's generic message" do
		@section.stubs(:current_assignment).returns [mock_section_assignment(due_date: Date.today + 1, assignment: mock_assignment('A current assignment'))]
		@section.stubs(:upcoming_assignments).returns [mock_section_assignment(due_date: Date.today + 2, assignment: mock_assignment('An upcoming assignment'))]
		@section.stubs(:past_assignments).returns [mock_section_assignment(due_date: Date.today - 2, assignment: mock_assignment('A past assignment'))]
		render
		rendered.should contain("This is my generic message")
		pending "Unfinished test"
	end
	
			
end
