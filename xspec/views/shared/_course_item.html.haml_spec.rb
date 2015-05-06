require 'spec_helper'

describe 'shared/_course_item' do
	it "renders a line item that contains the course's name and a link to its home page" do
		course = Fabricate(:course, full_name: "English Honors")
		render partial: 'shared/course_item', locals: {course: course}
		expect(rendered).to have_selector('li') do |li|
			expect(rendered).to have_selector('a', content: course.full_name)
		end
	end
end
