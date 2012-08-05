require 'spec_helper'

describe 'menus/_teacher' do
	it "should display a link to the teachers home page" do
		teacher = Fabricate(:teacher)
		render partial: 'menus/teacher', locals: {teacher: teacher}
		rendered.should have_selector('li.home-page') do |li|
			li.should have_selector('a', href: home_teacher_path(teacher))
		end
	end
			
end
