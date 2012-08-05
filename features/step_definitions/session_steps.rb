include Devise::TestHelpers

##
## Givens
##

Given /^(?:I am|I'm) signed in as (?:a|an) (teacher|admin)$/ do |user_type|
	step "the test teacher exists"
  @current_user = Fabricate(:user_test) unless @current_user

  @current_user.authentication_token.should be_present
  # visit '/admin' + "?auth_token=#{@current_user.authentication_token}"
end

# Given /^(?:I'm|I am) signed in as "([^"]*)"$/ do |email|
# 	step "#{user_type} User exists"
#   @current_user.authentication_token.should be_present
#   visit root_path + "?auth_token=#{@current_user.authentication_token}"
# end

Given /^the test teacher exists$/ do
	if User.where(email: 'teacher@example.com').exists? then
  	@current_user = User.find_by(email: 'teacher@example.com')
	else
  	@current_user = Fabricate(:test_teacher) unless @current_user
	end
end

Given /^(?:|the )Admin User exists$/ do
  @current_user = User.find_by(email: 'admin@example.com')

  @current_user = Fabricate(:test_admin) unless @current_user
  @admin_user = @current_user
end

# Given /^(?:|I )am signed in as (Test|Publisher) User$/ do |user_type|
#   step "#{user_type} User exists"
# 
#   @current_user.authentication_token.should be_present
#   visit crowdblog_path + "?auth_token=#{@current_user.authentication_token}"
# end
# 
# Given /^(?:|the )Test User exists$/ do
#   @current_user = Crowdblog::User.find_by_email('test@crowdint.com')
# 
#   @current_user = Fabricate(:user_test) unless @current_user
# end
# 
# Given /^(?:|the )Publisher User exists$/ do
#   @current_user = Crowdblog::User.find_by_email('publisher@crowdint.com')
# 
#   @current_user = Fabricate(:user_publisher) unless @current_user
#   @publisher_user = @current_user
# end
# # Given /^(?:|I )(?:am in|go to) the admin page$/ do
# #   visit crowdblog_path
# # end
# 
# When /^(?:|I )Sign Out$/ do
#   click_link 'Sign out'
# end

When /^I log in$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I am a registered user$/ do
  email = 'testing@man.net'
  password = 'secretpass'
  User.new(:email => email, :password => password, :password_confirmation => password).save!

  visit '/users/sign_in'
  fill_in "email", :with=>email
  fill_in "password", :with=>password
  click_button "Sign in"
end
