require 'spec_helper'

describe 'Courses' do
	it "shows a course page" do
		course = Fabricate(:course)
		get course_path(course)
		response.should render_template(:show)
	end
end
