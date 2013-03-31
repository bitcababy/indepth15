require 'spec_helper'

describe 'menus/_csection' do
  it "renders the section's course name" do
    view.stub :course_home_with_assts_path
    section = stub_model Section, course: stub_model(Course)
    section.stub(:menu_label).and_return "Fractals 101"
    # expect(section).to receive :menu_label  # Not implemented yet
    render partial: 'csection', locals: {section: section}
  end
    
end
