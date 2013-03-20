require 'spec_helper'

describe 'menus/_csection' do
  it "renders the section's course name" do
    view.stub :course_home_with_assts_path
    section = stub_model Section, course: stub_model(Course)
    section.stub(:label_for_course).and_return "Fractals 101"
    # expect(section).to receive :label_for_course  # Not implemented yet
    render partial: 'csection', locals: {section: section}
  end
    
end
