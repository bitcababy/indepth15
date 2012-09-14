### UTILITY METHODS ###
# From https://raw.github.com/RailsApps/rails3-devise-rspec-cucumber/master/features/step_definitions/user_steps.rb

def create_visitor
  @visitor ||= { :name => "Testy McUserton", :login => "tmcuserton",
    :password => "please", :password_confirmation => "please" }
end

def find_user
  @user ||= User.where(:login => @visitor[:login]).first
end

def create_user
  create_visitor
  delete_user
  @user = Fabricate(:user, login: @visitor[:login])
end

def delete_user
  @user ||= User.where(:login => @visitor[:login]).first
  @user.destroy unless @user.nil?
end

def sign_in
  visit '/users/sign_in'
	wait_for_ajax
  fill_in "Login", :with => @visitor[:login]
  fill_in "Password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong login$/ do
  @visitor = @visitor.merge(:login => "wrong")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

# When /^I edit my account details$/ do
#   click_link "Edit account"
#   fill_in "Name", :with => "newname"
#   fill_in "Current password", :with => @visitor[:password]
#   click_button "Update"
# end
# 
# When /^I look at the list of users$/ do
#   visit '/'
# end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see an invalid login message$/ do
  page.should have_content "Login is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid login or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end