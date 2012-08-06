require 'spec_helper'

describe 'menus/_login_item' do
	before :each do
		Fabricate :user
	end

	it "has a signin/signout item" do
		render partial: 'menus/login_item'
		rendered.should have_selector('li a', href: sign_in_path)
	end

	it "has an about item" do
		rendered.should have_selector('li a', href: about_path)
	end
	
end
