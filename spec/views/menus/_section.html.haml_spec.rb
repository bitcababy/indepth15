require 'spec_helper'

describe 'menus/_section' do
	include CourseExamplesHelper
	
	it "display a line item with the section's teacher and block" do
		pending "Unfinished test"
		teacher = Fabricate(:teacher, first_name: "Harry", last_name: "Smith")
		section = Fabricate(:section, teacher: teacher)
		render partial: 'menus/section', locals: {section: section}
		rendered.should have_selector('li a') do |link|
			pending "Unfinished test"
		end
	end
end
