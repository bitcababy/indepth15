require 'spec_helper'

describe 'menus/_courses' do
	it "renders a list for each course" do
		courses = []
		courses << Fabricate(:course, full_name: "Fractals")
		courses << Fabricate(:course, full_name: "Fubar")
		render partial: 'menus/courses', locals: {courses: courses}
		expect(rendered).to have_selector('li.courses') do |li|
			expect(li).to have_selector('a', href: '#', content: 'Courses')
			expect(li).to have_selector('ul.course-list') do |ul|
				expect(ul).to have_selector('a', content: "Fractals")
				expect(ul).to have_selector('a', content: "Fubar")
			end
		end
	end
end