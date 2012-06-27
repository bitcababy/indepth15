require 'spec_helper'

describe "menus/show.html.haml" do
	it "renders each menu" do
		render
		rendered.should have_selector("ul", id: 'menubar')
		puts '"'#{rendered}'"
		pending "Unfinished test"
		%W(Home Courses Teachers).each do |menu_title|
			menubar.should have_selector("li", id: menu_title.downcase, test: menu_title)
		end
	end
end
