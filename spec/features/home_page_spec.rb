require 'spec_helper'

feature "View home page" do
  include Warden::Test::Helpers
  include JqueryUIHelpers

  background do
    @dept = Fabricate :department_with_docs
    @docs = @dept.homepage_docs
  end

  scenario "should show an accordion", js: true do
    visit home_path
    assert_accordion_open
    within '.ui-accordion' do
      titles = page.all('.pane-title')
      expect(titles.count).to eq @docs.count
      contents = page.all('.pane-content')
      expect(contents.count).to eq @docs.count
      0.upto(2) do |i|
        expect(titles[i].text).to eq @docs[i].title
        expect(contents[i].text).to eq @docs[i].content
      end
      expect(titles[0]).to have_class 'ui-state-active'
    end
  end # User visits the home page
  
  scenario "should toggle panes", js: true do
    visit home_path
    assert_accordion_open
    within '.ui-accordion' do
      titles = page.all('.pane-title')
      titles[1].click
      expect(titles[1]).to have_class 'ui-state-active'
      expect(titles[0]).to_not have_class 'ui-state-active'
    end
  end

  scenario "should show edit buttons for logged-in users", js: true do
    login_as Fabricate :user
    visit home_path
    assert_accordion_open
    within '.ui-accordion' do
      for cont in page.all('.pane-content') do
        expect(cont).to have_selector('button.edit-button')
      end
    end
  end

  scenario "should open an editor in a dialog when an edit button is clicked", js: true do
    login_as Fabricate :user
    visit home_path
    assert_accordion_open
    expect(page).to have_selector('button.edit-button')
    btn = first('button.edit-button')
    pending "Clicking on this doesn't seem to hit the jQuery hook"
     btn.click
    assert_dialog_open
  end
   
end
