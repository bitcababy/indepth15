require 'spec_helper'

describe "admin/courses/index" do
  before(:each) do
    assign(:courses, [
      mock('course'),
      mock('course')
    ])
  end

  it "renders a list of courses" do
		pending "Unfinished test"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
