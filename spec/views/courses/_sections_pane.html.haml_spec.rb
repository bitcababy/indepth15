# encoding: UTF-8

require 'spec_helper'

describe "courses/_sections_pane" do
	include CourseMockHelpers
  before do
    stub_template 'courses/_sections_table' => "Sections table"
  end

  it "display a pane with the sections of a course" do
    course = mock_course_with_sections(6)
    assign(:course, course)
  
    course.stubs(:number).returns 321
    course.stubs(:duration).returns Course::FULL_YEAR
    course.stubs(:credits).returns 5.0
    course.stubs(:doc_of_kind).returns mock_text_doc("Some description")

    render partial: "courses/sections_pane", locals: {course: course}
    expect(rendered).to have_selector('div#sections_pane')
    expect(rendered).to have_content('Course 321 — Full Year ')
    expect(rendered).to have_content("Some description")
    expect(rendered).to have_content("In the #{academic_year_string(Settings.academic_year)} academic year there are 6 sections of Fractals 101.")
  end
	
end
