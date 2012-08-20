require 'spec_helper'

describe "courses/information_pane.html.haml" do
	include CourseMockHelpers
	it "displays the course information" do
		t = mock_text_doc("Some information")
		course = mock do
			stubs(:information).returns t
		end
		assign(:course, course)
		render
		rendered.should have_content("Some information")
	end
end
