require 'spec_helper'

describe "admin_users/new" do
  before(:each) do
    assign(:user, Fabricate.build(:user))
  end

  it "renders new user form" do
 		pending "Unfinished test"
   render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_users_path, :method => "post" do
    end
  end
end
