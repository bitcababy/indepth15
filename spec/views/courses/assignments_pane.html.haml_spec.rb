require 'spec_helper'

describe 'courses/assignments_pane' do
	include CourseMockHelpers
	
	it "shows the assignments of a particular section" do
		section = mock_section_with_assignments
		assign(:section, section)
		render
		rendered.should have_selector('iframe')
	end
	
	
end

