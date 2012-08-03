require 'spec_helper'

describe "users/edit" do
  before(:each) do
		pending "Unfinished test"
    @user = assign(:user, stub_model(User))
  end

  it "renders the edit user form" do
 		pending "Unfinished test"
   render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
    end
  end
end
