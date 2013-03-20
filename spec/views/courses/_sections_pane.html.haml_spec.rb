# encoding: UTF-8

require 'spec_helper'

describe "courses/_sections_pane" do

  before do
    stub_template 'courses/_sections_table' => "Sections table"
  end

  it "display a pane with the sections of a course" do
    course = mock_model Course, number: 321, duration: Course::FULL_YEAR, credits: 5.0, full_name: "Fractals 101"
    course.stub(:sections).and_return course
    course.stub(:current).and_return [1,2,3]
    course.stub(:doc_of_kind).and_return mock_model(TextDocument, content: "Some description")
    assign(:course, course)
  
    render partial: "courses/sections_pane", locals: {course: course}
    expect(rendered).to have_selector('div#sections_pane')
    expect(rendered).to have_content('Course 321 — Full Year ')
    expect(rendered).to have_content("Some description")
    expect(rendered).to have_content("In the #{academic_year_string(Settings.academic_year)} academic year there are 3 sections of Fractals 101.")
  end
	
end
