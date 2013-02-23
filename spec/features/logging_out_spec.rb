require 'spec_helper'

feature "Logging out" do
  include Warden::Test::Helpers

  scenario "Click 'Sign out' signs out the user", :js do
    @dept = Fabricate :department_with_docs
    @user = Fabricate :user
    login_as @user
    visit home_path
    page.should have_selector('#username', text: @user.full_name)
    menu = page.first '#usermenu'
    menu.should_not be_nil
    menu.click
    item = menu.first '#signout'
    item.should_not be_nil
    item.click
    pending "unfinished test"
    page.should have_selector('#username', text: "Guest")
  end
end
