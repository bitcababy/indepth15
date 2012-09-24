require 'spec_helper'

describe 'menus/_csection' do
	
	it "display a line item with the section's teacher and block" do
		course = mock do
			stubs(:to_param).returns 321
		end
		teacher = mock do
			stubs(:formal_name).returns "Mr. Ed"
			stubs(:to_param).returns "edh"
		end
		section = mock do
			stubs(:course).returns course
			stubs(:block).returns block
			stubs(:block).returns "B"
			stubs(:teacher).returns teacher
			stubs(:academic_year).returns 2013
			stubs(:label_for_course).returns "Mr. Ed, Block B"
		end
		render partial: 'menus/csection', locals: {section: section}
		rendered.should have_selector('li.section') do |li|
			li.should have_selector('a', href: assignments_page_path(321, 2013, 'edh', 'B'))
		end
			
	end
end
