require 'spec_helper'

feature "User clicks on" do
  before :each do
    @dept = Fabricate :department_with_docs
    visit home_path
  end

  scenario "Courses menu", :js do
    within '#menubar' do
      click_link 'Courses'
      pending "unfinished test"
    end
  end
end

