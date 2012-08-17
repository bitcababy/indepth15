require 'spec_helper'

describe 'shared/_course_link' do
	it "returns a link to a course" do
		course = Fabricate(:course, full_name: 'Fractals')
		render partial: 'shared/course_link', locals: {course: course}
		rendered.should have_selector("a", content: course.full_name, href: course_path(course))
	end
end
