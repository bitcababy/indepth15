require 'spec_helper'

describe 'assignment requests' do
	include CourseExamplesHelper
	it "should render the guest assignments page" do
		course = course_with_sections
		get "/course/#{course.number}/block/#{course.sections.first.block}/assignments"
	  response.should render_template(:page)
	end
end
  