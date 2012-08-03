require 'spec_helper'

describe "users/index" do
  before(:each) do
		pending "Unfinished test"
    assign(:users, [
      stub_model(User),
      stub_model(User)
    ])
  end

  it "renders a list of users" do
		pending "Unfinished test"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
