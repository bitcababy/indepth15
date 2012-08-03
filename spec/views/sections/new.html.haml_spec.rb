require 'spec_helper'

describe "sections/new" do
  before(:each) do
    assign(:section, stub_model(Section).as_new_record)
  end

  it "renders new section form" do
 		pending "Unfinished test"
   render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sections_path, :method => "post" do
    end
  end
end
