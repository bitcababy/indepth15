require 'spec_helper'

describe "courses/_news_pane.html.haml" do
	include CourseMockHelpers
	it "displays the course information" do
		t = mock_text_doc("Some news")
		course = mock('course') do
			stubs(:news).returns t
		end
		assign(:course, course)
		render partial: 'courses/news_pane', locals: {course: course}
		rendered.should have_content("Some news")
	end
end
