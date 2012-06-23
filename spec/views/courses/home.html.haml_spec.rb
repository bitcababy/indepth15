require 'spec_helper'

describe 'courses/home' do
	it "sets the page_header to the full name of the course" do
		course = Fabricate(:course, full_name: "Foo")
		assign(:course, course)
		pending "Not sure how to test this"
	end

	it "shows a various tabs" do
		course = Fabricate(:course, full_name: "Foo")
		assign(:course, course)
		render
		rendered.should have_selector('#tabs ul')
		for tab_name in %W(Sections Information Resources Policies News) do
			rendered.should have_selector('#tabs ul li a', title: tab_name, text: tab_name)
		end
	end
end
