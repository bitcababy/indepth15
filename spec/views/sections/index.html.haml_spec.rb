require 'spec_helper'

describe "sections/index" do
  before(:each) do
		pending "Unfinished test"
    assign(:sections, [
      stub_model(Section),
      stub_model(Section)
    ])
  end

  it "renders a list of sections" do
		pending "Unfinished test"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
