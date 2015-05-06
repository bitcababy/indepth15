require 'spec_helper'

describe 'menus/_menubar' do
  before do
    stub_template 'menus/home' => "<li>Home</li>"
    stub_template 'menus/_courses' => "<li>Courses/<li>"
    stub_template 'menus/_faculty' => "<li>Faculty</li>"
    stub_template 'menus/manage' => "<li>Manage/li>"
    stub_template 'menus/username' => "<li>Guest/li>"
  end

  it "displays the Home menu" do
    as_guest do
      render
    end
    pending "unfinished test"
  end
    
  it "displays the Courses menu"
  it "displays the Faculty menu"
  it "displays the Manage menu if the user is signed in" do
    pending "This is broken right now"
    as_user do
      render
      pending "unfinished test"
    end
  end
  it "doesn't display the Manage menu if the user is signed in"
end
