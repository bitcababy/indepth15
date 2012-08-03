require 'spec_helper'

describe 'menus/_teacher' do
	it "should display a link to the teachers home page" do
		teacher = mock do
			stubs(:full_name).returns "John Doe"
			stubs(:to_s).returns "1"
			stubs(:id).returns 1
		end
		render partial: 'menus/teacher', locals: {teacher: teacher}
		rendered.should have_selector('li.home-page') do |li|
			li.should have_selector('a', href: home_teacher_path(@teacher))
		end
	end
			
		
end
