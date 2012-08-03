require 'spec_helper'

describe 'sections/_form' do
	before :each do
		@current_user = @teacher = Fabricate :teacher, login: "foobar", email: "foo@example.com"
		@course = Fabricate :course, full_name: 'Fractals 101'
	end
	
	context "methods with existing section" do
		before :each do
			@section = Fabricate :section, teacher: @teacher, course: @course, block: 'A', room: '5', semester: COURSE::FULL_YEAR, occurrences: (1..5).to_a, academic_year: 2012
		end
	end
	
	context "methods with new section" do
		before :each do
			@section = Fabricate.build :section, course: @course, teacher: @teacher
			assign(:section, @section)
			render partial: 'sections/form'
		end
		
		it "asks for the block" do
			rendered.should have_selector('input', name: 'section[block]')
		end
		it "asks for the room" do
			rendered.should have_selector('input', name: 'section[room]')
		end
			
		it "asks for the semester" do
			rendered.should have_selector('select', name: 'section[semester]')
		end
		
		it "asks for the occurrences"do
			rendered.should have_selector('input', name: 'section[occurrences][]')
		end
		
		it "displays the course name" do
			rendered.should contain(@course.full_name)
		end
					
	end
	
end

