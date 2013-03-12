require 'spec_helper'

describe 'menus/_course' do
	it "displays a course and its sections" do
		sections = []
		course = mock('course') do
			stubs(:menu_label).returns "Fractals 101"
			stubs(:sorted_sections).returns sections
			stubs(:number).returns 321
		end
		render partial: 'menus/course', locals: {course: course}
		expect(rendered).to have_selector('li.course', text: 'Fractals 101') do |li|
			pending "This needs a real model."
			# expect(li).to have_selector('a', href: '/courses/321')
		end
	end

end
