require 'spec_helper'

describe "teachers/show.html.haml" do
	before :each do
		@teacher = Fabricate(:teacher)
		course2 = Fabricate(:course, full_name: "Geometry Honors")
		course1 = Fabricate(:course, full_name: "Fractals")
		Fabricate(:section, teacher: @teacher, course: course1, block: "A")
		Fabricate(:section, teacher: @teacher, course: course1, block: "B")
		Fabricate(:section, teacher: @teacher, course: course2, block: "C")
		Fabricate(:section, teacher: @teacher, course: course2, block: "D")
		render
	end
		
	it "should have an area for the teacher's picture" do
		rendered.should have_selector('div#teacher-pic') do
			pending "Unfinished test"
		end
	end

	it "should have a list of the teacher's courses" do
		rendered.should have_selector('div#courses') do |div|
			div.should have_selector('ul') do |ul|
				ul.should have_selector('li a', content: 'Fractals')
				ul.should have_selector('li a', content: 'Geometry Honors')
			end
		end
	end
		
	it "should have a list for other links"
end
