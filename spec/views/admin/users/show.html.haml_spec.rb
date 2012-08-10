require 'spec_helper'

describe "admin_users/show" do
  before(:each) do
    @user = assign(:user, Fabricate(:user))
  end

  it "renders attributes in <p>" do
		pending "Unfinished test"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
