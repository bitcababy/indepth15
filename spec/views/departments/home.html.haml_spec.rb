require 'spec_helper'

describe "departments/home.html.haml" do
  include DepartmentHelper

  before :each do
    view.stubs(:edit_text_document_path).returns "foo"
    stub_template 'shared/_pane.html.haml' => "a pane"
    @dept = mock_department
    assign(:dept, @dept)
    render
  end
      
  it "has a div named 'home-page'" do
    rendered.should have_selector('#home-page')
  end
  it "renders a number of panes within #home-page" do
    rendered.should have_selector('#home-page')
  end

end
