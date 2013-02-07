require 'spec_helper'

feature "Logging in" do
  include DeviseHelpers

  before :each do
    @dept = Fabricate :department_with_docs
    @user = Fabricate :user, login: 'doej', first_name: 'John', last_name: 'Doe', password: 'secret'
    puts @user.attributes
  end

  def open_login_dialog
    visit home_path
    menu = page.first '#usermenu'
    menu.click
    signin = menu.first '#sign_in_out'
    signin.click
  end
  
  scenario "clicking 'Sign in' should bring up a sign-in dialog", js: true do
    # Have to be on a pages
    open_login_dialog
    page.should have_selector('.ui-dialog')
  end
  
  
  scenario "valid user should be able to sign in", js: true do
    open_login_dialog
    dialog = page.first '.ui-dialog'
    dialog.should_not be_nil
    within '.ui-dialog form' do
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: 'secret'
    end
    click_button 'Sign in'
    pending
  end
end