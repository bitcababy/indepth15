require 'spec_helper'

describe "teacher/sections/show" do
  before(:each) do
    @section = assign(:section, Fabricate(:section))
  end

  it "renders attributes in <p>" do
		pending "Unfinished test"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
