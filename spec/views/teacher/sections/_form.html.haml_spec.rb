require 'spec_helper'

describe 'teacher/sections/_form' do
	it "renders a form for a section" do
		pending "Unfinished test"
		course = mock do
			stubs(:full_name).returns 'Fractals 101'
		end
		section = Section.new room: "5"
		assign(:section, section)
		render partial: 'sections/form', locals: {section: section}
		rendered.should have_selector('form') do |form|
			form.should have_selector('input', name: 'section[block]')
			form.should have_selector('input', name: 'section[room]')
			form.should have_selector('select', name: 'section[semester]')
			form.should have_selector('input', name: 'commit', type: 'submit')
		end
	end
	
end

