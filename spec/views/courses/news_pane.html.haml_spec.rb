require 'spec_helper'

describe "courses/news_pane.html.haml" do
	it "displays the course information" do
		course = mock do
			stubs(:news).returns "Some news"
		end
		assign(:course, course)
		render
		rendered.should have_content("Some news")
	end
end
