require 'spec_helper'

describe 'menus/_courses' do
	before :each do
		courses = []
		courses << mock
		courses << mock
		render partial: 'menus/courses', locals: {courses: courses}
	end

	it "renders a list for each course" do
		rendered.should have_selector('li.courses') do |li|
			li.should have_selector('a', href: '#', content: 'Courses')
			li.should have_selector('ul.course-list')
		end
	end
end