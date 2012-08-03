require 'spec_helper'

describe 'menus/_home' do
	before :each do
		render partial: 'menus/home'
	end

	it "has a signin/signout item" do
		rendered.should have_selector('li a', href: sign_in_path)
	end

	it "has an about item" do
		rendered.should have_selector('li a', href: about_path)
	end
		
end
