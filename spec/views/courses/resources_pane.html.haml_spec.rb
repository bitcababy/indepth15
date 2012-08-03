require 'spec_helper'

describe "courses/resources_pane.html.haml" do
	it "displays the course information" do
		course = mock do
			stubs(:resources).returns "Some resources"
		end
		assign(:course, course)
		render
		rendered.should have_content("Some resources")
	end
end
