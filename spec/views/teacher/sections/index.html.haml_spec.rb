require 'spec_helper'

describe "teacher/sections/index" do
  before(:each) do
    assign(:teacher_sections, [
      Fabricate(:section),
      Fabricate(:section)
    ])
  end

  it "renders a list of teacher_sections" do
		pending "Unfinished test"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
