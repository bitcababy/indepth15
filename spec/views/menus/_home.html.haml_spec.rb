require 'spec_helper'

describe 'menus/_home' do
  it "goes to the home page if on another page" do
    view.stub(:current_page?).and_return false
    render
    expect(page).to have_link 'Home', href: '/'
  end
    
  it "does nothing if it's on the home page'" do
    view.stub(:current_page?).and_return true
    render
    expect(page).to have_link 'Home', href: '#'
  end
		
end
