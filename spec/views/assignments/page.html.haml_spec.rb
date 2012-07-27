require 'spec_helper'

describe "sections/assignments.html.haml" do
	include CourseExamplesHelper
	before :each do
		course = Fabricate :course, full_name: 'Math 101'
		teacher = Fabricate :teacher, 
							honorific: "Mr.", last_name: "Masterson", 
							generic_msg: "This is my generic message",
							current_msg: "This is my current message",
							upcoming_msg: "This is my upcoming message"
		@section = Fabricate :section, teacher: teacher, course: course
		add_some_assignments(@section, 3, 2)
		assign(:section, @section)
		pending "Need to deal with @current_assignments, etc."
	end

  it "displays a header for the assignments" do
	
		render
		rendered.should have_selector('div#header') do |div|
			div.text.should =~ /#{academic_year_string(Settings.academic_year)} Assignments/
		end
	end
	
	it "displays the teacher's generic message" do
		render
		rendered.should contain("This is my generic message")
	end
	
			
end
