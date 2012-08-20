require 'spec_helper'

describe "courses/resources_pane.html.haml" do
	include CourseMockHelpers
	
	before :each do
		t = mock_text_doc("Some resources")
		course = mock do
			stubs(:resources).returns t
		end
		assign(:course, course)
	end
		
	it "displays the course information" do
		render
		rendered.should have_content("Some resources")
	end
	
	it "shows an edit button if the user is signed in" do
		pending "Unfinished test"
		render
		rendered.should have_selector('a', href: edit_resources_course_path, content: 'Edit')
	end
end
