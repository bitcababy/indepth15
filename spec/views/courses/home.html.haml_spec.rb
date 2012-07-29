require 'spec_helper'

describe 'courses/home' do
	include CourseExamplesHelper

	it "shows various tabs" do
		assign(:course, course_with_sections)
		render
		rendered.should have_selector('#tabs ul') do |ul|
			for tab_name in %W(Sections Information Resources Policies News) do
				ul.should have_selector('li', id: tab_name.downcase) do |li|
					li.should have_selector('a', title: tab_name, content: tab_name)
				end
			end
		end
	end
end
