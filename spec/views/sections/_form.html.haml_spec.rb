require 'spec_helper'

describe 'sections/_form' do
	before :each do
		@course = mock do
			stubs(:full_name).returns 'Fractals 101'
		end
		@section = Section.new
		assign(:section, @section)
		render partial: 'sections/form', locals: {section: @section}
	end
	
	context "Methods for new or edit" do
		it "renders a form" do
			rendered.should have_selector('form')
		end
		it "has inputs for the block" do
			rendered.should have_selector('input', name: 'section[block]')
		end
		it "has inputs for the room" do
			rendered.should have_selector('input', name: 'section[room]')
		end
			
		it "has inputs for the semester" do
			rendered.should have_selector('select', name: 'section[semester]')
		end
		
	end
	
end

