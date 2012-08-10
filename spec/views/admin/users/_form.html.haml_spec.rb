require 'spec_helper'

describe 'admin/users/_form' do
	before :each do
		pending "Unfinished test"
		user = User.new
		assign(:user, user)
		render partial: 'admin/users/form'
		rendered.should have_selector('form') do |form|
			@form = form
		end
	end
	
	context "fields" do
		pending "Unfinished test"
		it "should have a Honorific field" do
			@form.should have_selector('select', name: 'user[honorific]')
		end
		
		it "should have a First name field" do
			@form.should have_selector('input', name: 'user[first_name]')
		end
		
		it "should have a Middle name field" do
			@form.should have_selector('input', name: 'user[middle_name]')
		end
		it "should have a Last name field" do
			@form.should have_selector('input', name: 'user[last_name]')
		end
		it "should have a Email field" do
			@form.should have_selector('input', name: 'user[email]')
		end
		it "should have a Login field" do
			@form.should have_selector('input', name: 'user[login]')
		end
		it "should have a Password field" do
			@form.should have_selector('input', name: 'user[password]')
		end
		it "should have a Verify password field" do
			@form.should have_selector('input', name: 'user[verify_password]')
		end
	end
	
	
end
