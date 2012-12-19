require 'spec_helper'

describe "courses/resources_pane.html.haml" do
	include CourseMockHelpers
	
	before :each do
		t = mock_text_doc("Some resources")
		course = mock do
			stubs(:resources).returns t
		end
		render partial: 'courses/resources_pane', locals: {course: course}
	end
		
	it "displays the course information" do
		rendered.should have_content("Some resources")
	end
	
end
