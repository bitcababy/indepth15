require 'spec_helper'

describe "courses/information_pane.html.haml" do
	it "displays the course information" do
		course = mock do
			stubs(:information).returns "Some information"
		end
		assign(:course, course)
		render
		rendered.should have_content("Some information")
	end
end
