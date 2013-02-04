require 'spec_helper'

feature "Home page" do
  before :each do
    @dept = Fabricate :department
    @docs = [
      Fabricate(:department_document, department: @dept, title: 'Tab 2', content: 'Content 2', pos: 2),
      Fabricate(:department_document, department: @dept, title: 'Tab 1', content: 'Content 1', pos: 1),
      Fabricate(:department_document, department: @dept, title: 'Tab 3', content: 'Content 2', pos: 3)
    ]
    @docs.sort!
  end

  scenario "User visits the home page", js: true do
    visit home_path
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
  
  scenario "User click a closed pane", js: true do
    visit home_path
    within '.ui-accordion' do
      titles = page.all('.pane-title')
      titles[1].click
      titles[1].should have_class 'ui-state-active'
      titles[0].should_not have_class 'ui-state-active'
    end
  end
  
end
