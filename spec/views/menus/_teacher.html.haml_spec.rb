require 'spec_helper'

describe 'menus/_teacher' do
	before :each do
		pending "Unfinished test"
		@teacher = Fabricate(:teacher, first_name: "Harry", last_name: "Smith")
		render partial: 'menus/teacher', locals: {teacher: @teacher}
	end
		
	it "should display the teacher's full name" do
		rendered.should have_selector('li', content: @teacher.full_name)
	end

	it "should display a link to the teachers home page" do
		rendered.should have_selector('li.home-page') do |li|
			li.should have_selector('a', href: teacher_path(@teacher))
		end
	end
			
		
end
