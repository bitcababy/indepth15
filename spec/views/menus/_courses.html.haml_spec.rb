require 'spec_helper'

describe 'menus/_courses' do
	it "renders a list for each course" do
		courses = []
		courses << Fabricate(:course, full_name: "Fractals")
		courses << Fabricate(:course, full_name: "Fubar")
		render partial: 'menus/courses', locals: {courses: courses}
		rendered.should have_selector('li.courses') do |li|
			li.should have_selector('a', href: '#', content: 'Courses')
			li.should have_selector('ul.course-list') do |ul|
				ul.should have_selector('a', content: "Fractals")
				ul.should have_selector('a', content: "Fubar")
			end
		end
	end
end