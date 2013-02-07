require 'spec_helper'

feature "Home page" do
  before :each do
    @dept = Fabricate :department_with_docs
    @docs = @dept.homepage_docs
    visit home_path
   end

  scenario "should show an accordion", js: true do
    within '.ui-accordion' do
      titles = page.all('.pane-title')
      titles.count.should eq @docs.count
      contents = page.all('.pane-content')
      contents.count.should eq @docs.count
      0.upto(2) do |i|
        titles[i].text.should eq @docs[i].title
        contents[i].text.should eq @docs[i].content
      end
      titles[0].should have_class 'ui-state-active'
    end
  end # User visits the home page
  
  scenario "should toggle panes", js: true do
    within '.ui-accordion' do
      titles = page.all('.pane-title')
      titles[1].click
      titles[1].should have_class 'ui-state-active'
      titles[0].should_not have_class 'ui-state-active'
    end
  end

end

feature "Home page" do
  include Warden::Test::Helpers
  Warden.test_mode!

  before :each do
    @dept = Fabricate :department_with_docs
    @docs = @dept.homepage_docs
    login_as Fabricate(:user), scope: :user
    visit home_path
   end

  scenario "should show edit buttons for logged-in users", js: true do
     within '.ui-accordion' do
       for cont in page.all('.pane-content') do
         cont.should have_selector('button.edit-button')
       end
     end
   end

  scenario "should open an editor in a dialog when an edit button is clicked", js: true do
    within '.ui-accordion' do
      page.first('button.edit-button').click
    end
    page.should have_selector('.ui-dialog')
  end
   
end
