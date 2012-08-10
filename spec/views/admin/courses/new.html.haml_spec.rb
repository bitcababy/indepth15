require 'spec_helper'

describe "admin/courses/new" do
  before(:each) do
    assign(:course, Fabricate.build(:course))
  end

  it "renders new course form" do
		pending "Unfinished test"
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_courses_path, :method => "post" do
    end
  end
end
