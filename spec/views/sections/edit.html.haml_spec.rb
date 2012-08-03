require 'spec_helper'

describe "sections/edit" do
	include CourseMockHelpers
	
  before(:each) do
		pending "Unfinished test"
    @section = assign(:section, mock_section)
  end

  it "renders the edit section form" do
		pending "Unfinished test"
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sections_path(@section), :method => "post" do
    end
  end
end
