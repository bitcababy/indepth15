require 'spec_helper'

describe 'menus/_courses' do
	it "displays a course and its sections" do
		sections = mock do
			stubs(:current).returns []
		end
		course = mock do
			stubs(:full_name).returns "Fractals 101"
			stubs(:sections).returns sections
		end
		render partial: 'menus/course', locals: {course: course}
		rendered.should have_selector('li.course', content: 'Fractals 101')
	end

end