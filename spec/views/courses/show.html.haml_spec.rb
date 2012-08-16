require 'spec_helper'

describe 'courses/show' do
	include CourseMockHelpers

	it "shows various tabs" do
		course = mock do
			stubs(:full_name).returns "Fractals 101"
		end
		assign(:course, course)
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
