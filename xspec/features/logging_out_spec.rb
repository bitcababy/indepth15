require 'spec_helper'

feature "Logging out" do
  include Warden::Test::Helpers
  
  background do
    @dept = Fabricate :department_with_docs
    @user = Fabricate :user
    login_as @user
    visit home_path
  end

  scenario "Click 'Sign out' signs out the user", :js do
    expect(page).to have_selector('#username', text: @user.full_name)
    menu = page.first '#usermenu'
    menu.click
    click_link "Sign out"
    expect(page).to have_selector('#username', text: "Guest")
  end
end
