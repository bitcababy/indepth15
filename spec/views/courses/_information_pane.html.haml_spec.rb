require 'spec_helper'

describe "courses/_information_pane.html.haml" do
	include CourseMockHelpers
	it "displays the course information" do
    t = mock do
      stubs(:content).returns "Foo"
    end
		course = mock do
			stubs(:information).returns t
		end
    assign(:course, course)
    view.stubs(:editable?).returns false
		render partial: 'courses/information_pane'
		rendered.should have_content(t.content)
	end
end
