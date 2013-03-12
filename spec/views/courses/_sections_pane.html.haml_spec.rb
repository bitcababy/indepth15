# encoding: UTF-8

require 'spec_helper'

describe "courses/_sections_pane" do
	include CourseMockHelpers

  it "display a pane with the sections of a course" do
    course = mock_course_with_sections(6)
    assign(:course, course)
  
    course.stubs(:number).returns 321
    course.stubs(:duration).returns Course::FULL_YEAR
    course.stubs(:credits).returns 5.0
    course.stubs(:doc_of_kind).returns mock_text_doc("Some description")
    stub_template 'courses/_sections_table' => "Sections table"

    render partial: "courses/sections_pane", locals: {course: course}
    expect(rendered).to have_selector('div#sections_pane') do |div|
      expect(div).to contain('Course 321 — Full Year ')
      expect(div).to contain("Some description")
      expect(div).to contain("In the #{academic_year_string(Settings.year)} academic year there are 6 sections of Fractals 101.")
    end
  end
	
end
