require 'spec_helper'

describe 'menus/_course' do
  before do
    stub_template 'shared/_course_link' => "/course/1"
    stub_template 'menus/_csection' => "a section"
  end

	it "displays 'Not taught this year' if there are no sections" do
    course = stub_model Course
    course.stub(:sorted_sections).and_return []
		render partial: 'menus/course', locals: {course: course}
    expect(rendered).to have_content('Not taught this year')
	end
  
  it "Displays an unordered list if there are sections" do
    course = stub_model Course
    course.stub(:sorted_sections).and_return [1]
		render partial: 'menus/course', locals: {course: course}
  end
    

end
