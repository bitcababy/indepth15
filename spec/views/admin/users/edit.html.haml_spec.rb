require 'spec_helper'

describe "admin_users/edit" do
  before(:each) do
    @user = assign(:user, Fabricate(:user))
  end

  it "renders the edit user form" do
		pending "Unfinished test"
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_users_path(@user), :method => "post" do
    end
  end
end
