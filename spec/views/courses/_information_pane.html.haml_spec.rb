require 'spec_helper'

describe "courses/_information_pane" do
	include CourseMockHelpers
	it "displays the course information" do
    t = mock do
      stubs(:content).returns "Foo"
    end
		course = mock do
			stubs(:information).returns t
		end
    view.stubs(:editable?).returns false
		render partial: 'courses/information_pane', locals: {course: course}
		rendered.should have_content(t.content)
	end
end
