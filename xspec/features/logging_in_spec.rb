require 'spec_helper'

feature "The sign-in process" do
  include Warden::Test::Helpers

  background do
    @dept = Fabricate :department_with_docs
    @user = Fabricate :user, login: "foo", password: "password"
  end

  scenario "signs me in", js: true do
    logout
    visit home_path
    expect(page).to have_selector('#username', text: "Guest")
    expect(page).to_not have_selector('#username', text: @user.full_name)
    signin_link = page.first '#signin'
    signin_link.click
    
    within '#signinform form' do
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: @user.password
    end
    click_button 'Sign in'
    expect(page).to have_selector('#username', text: @user.full_name)
  end
end
