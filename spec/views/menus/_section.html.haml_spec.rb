require 'spec_helper'

describe 'menus/_section' do
	
	it "display a line item with the section's teacher and block" do
		course = mock do
			stubs(:number).returns "321"
		end
		teacher = mock do
			stubs(:formal_name).returns "Mr. Ed"
		end
		section = mock do
			stubs(:course).returns course
			stubs(:block).returns block
			stubs(:to_s).returns "1"
			stubs(:block).returns "B"
			stubs(:teacher).returns teacher
		end
		render partial: 'menus/section', locals: {section: section}
		rendered.should have_selector('li.section') do |li|
			li.should have_selector('a', href: section_path(1))
		end
			
	end
end
