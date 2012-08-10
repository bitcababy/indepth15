require 'spec_helper'

describe "admin/sections/index" do
  before(:each) do
    assign(:sections, [
      Fabricate(:section),
      Fabricate(:section)
    ])
  end

  it "renders a list of admin_sections" do
		pending "Unfinished test"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
