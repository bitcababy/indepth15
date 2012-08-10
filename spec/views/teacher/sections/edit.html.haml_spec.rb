require 'spec_helper'

describe "teacher/sections/edit" do
  before(:each) do
    @section = assign(:section, Fabricate(:section))
  end

  it "renders the edit section form" do
		pending "Unfinished test"
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teacher_sections_path(@section), :method => "post" do
    end
  end
end
