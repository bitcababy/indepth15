require 'spec_helper'

describe "courses/policies_pane.html.haml" do
	it "displays the course information" do
		course = mock do
			stubs(:policies).returns "Some policies"
		end
		assign(:course, course)
		render
		rendered.should have_content("Some policies")
	end
end
