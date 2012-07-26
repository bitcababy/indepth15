require 'spec_helper'

describe 'menus/_courses' do
	include CourseExamplesHelper

	it "displays a course and its sections" do
		pending "Unfinished test"
		course = Fabricate(:course, full_name: 'Fractals')
		3.times {course.sections << Fabricate(:section) }
		render partial: 'menus/course', locals: {course: course}
		rendered.should have_selector('li.course') do |li|
			li.should have_content('Fractals')
		end
		rendered.should have_selector('ul li')				
	end

end