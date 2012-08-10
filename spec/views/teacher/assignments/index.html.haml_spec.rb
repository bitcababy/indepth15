require 'spec_helper'

describe "teacher/assignments/index" do
  before(:each) do
    assign(:assignments, [
      Fabricate(:assignment),
      Fabricate(:assignment)
    ])
  end

  it "renders a list of teacher_assignments" do
		pending "Unfinished test"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
