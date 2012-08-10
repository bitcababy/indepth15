require 'spec_helper'

describe "teacher/assignments/show" do
  before(:each) do
    @assignment = assign(:assignment, Fabricate(:assignment))
  end

  it "renders attributes in <p>" do
		pending "Unfinished test"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
