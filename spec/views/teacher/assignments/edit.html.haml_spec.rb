require 'spec_helper'

describe "teacher/assignments/edit" do
  before(:each) do
    @assignment = assign(:assignment, Fabricate(:assignment))
  end

  it "renders the edit assignment form" do
		pending "Unfinished test"
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teacher_assignments_path(@assignment), :method => "post" do
    end
  end
end
