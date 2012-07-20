require 'spec_helper'

describe 'courses/show' do
	it "sets the page_header to the full name of the course" do
		course = Fabricate(:course, full_name: "Foo")
		assign(:course, course)
		render
		rendered.should have_selector('#page_header') do |div|
			div.should contain('Foo')
		end
	end

	include CourseExampleHelpers

	it "shows various tabs" do
		assign(:course, course_with_sections)
		render
		rendered.should have_selector('#tabs ul') do |ul|
			for tab_name in %W(Sections Information Resources Policies News) do
				ul.should have_selector('li', id: tab_name.downcase) do |li|
					li.should have_selector('a', title: tab_name) do |a|
						a.text.should == tab_name
					end
				end
			end
		end
	end
end
