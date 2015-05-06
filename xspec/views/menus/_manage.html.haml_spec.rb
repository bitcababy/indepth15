require 'spec_helper'

describe 'menus/_manage' do
  it "has 'manage' as its title" do
    render
    expect(page).to have_link("Manage", href: '#')
  end
end
