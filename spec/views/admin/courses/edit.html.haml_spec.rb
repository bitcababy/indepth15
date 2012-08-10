require 'spec_helper'

describe "admin/courses/edit" do
  before(:each) do
    @course = assign(:course, Fabricate(:course))
  end

  it "renders the edit course form" do
		pending "Unfinished test"
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_courses_path(@course), :method => "post" do
    end
  end
end
