require 'spec_helper'

describe "teacher/sections/new" do
  before(:each) do
    assign(:section, Fabricate.build(:section))
  end

  it "renders new section form" do
		pending "Unfinished test"
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teacher_sections_path, :method => "post" do
    end
  end
end
