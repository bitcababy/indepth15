require 'spec_helper'

describe "courses/_policies_pane.html.haml" do
	include CourseMockHelpers

	it "displays the course information" do
		t = mock_text_doc("Some policies")
		course = mock('course') do
			stubs(:policies).returns t
		end
    assign(:course, course)
    view.stubs(:editable?).returns false
		render partial: 'courses/policies_pane'
		rendered.should have_content("Some policies")
	end
end
