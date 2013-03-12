require 'spec_helper'

describe 'menus/_csection' do
	before do
    view.stubs(:home_with_assignments_path).returns ""
  end

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
			stubs(:year).returns 2013
			stubs(:label_for_course).returns "Mr. Ed, Block B"
		end
		render partial: 'menus/csection', locals: {section: section}
		expect(rendered).to have_selector('li.section') do |li|
			expect(li).to have_selector('a', href: course_home_with_assignments(section))
		end
			
	end
end
