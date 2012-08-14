require 'spec_helper'

describe MenusController do
	it "renders the home menu" do
		get :home
		response.should be_success
  end
	it "renders the courses menu" do
		get :courses
		response.should be_success
  end
	it "renders the faculty menu" do
		get :faculty
		response.should be_success
  end
	it "renders the manage menu" do
		get :manage
		response.should be_success
  end
	it "renders the courses menu via js" do
		xhr :get, :courses
		response.should be_success
  end
	it "renders the faculty menu via js" do
		xhr :get, :faculty
		response.should be_success
  end
	it "renders the manage menu via js" do
		xhr :get, :manage
		response.should be_success
  end

end
