require 'spec_helper'

describe 'menus/_home' do
	before :each do
		pending "Unfinished test"
		render partial: 'menus/home'
		rendered.should have_selector("div#home-menu")
	end

	it "has a signin/signout item" do
		rendered.should have_selector('li a', href: sign_in_path)
	end

	it "has an about item" do
		rendered.should have_selector('li a', href: about_path)
	end
		
end
