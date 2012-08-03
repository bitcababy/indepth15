require 'spec_helper'

describe 'menus/_courses' do
	include CourseExamplesHelper

	before :each do
		pending "Unfinished test"
		courses = []
		5.times {|i| courses << Fabricate(:course) }
		render partial: 'menus/courses', locals: {courses: courses}
	end

	it "renders a list for each course" do
		rendered.should have_selector('div#courses-menu')
	end
end