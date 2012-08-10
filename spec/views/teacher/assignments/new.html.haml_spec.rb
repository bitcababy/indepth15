require 'spec_helper'

describe "teacher/assignments/new" do
  before(:each) do
    assign(:assignment, Fabricate.build(:assignment))
  end

  it "renders new assignment form" do
		pending "Unfinished test"
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teacher_assignments_path, :method => "post" do
    end
  end
end
