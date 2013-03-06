require 'spec_helper'

describe "departments/_pane.html" do
  include ViewMacros
  it "displays one of the department's panes" do
    pane = Fabricate :titled_document, title: "The title", content: "The content"
    as_guest
    render 'departments/pane', pane: pane
    expect(rendered).to match pane.title
    expect(rendered).to match pane.content
  end
  
  it "shows an edit button iff the user is logged in" do
    d = Fabricate :department
    pane = d.homepage_docs.create title: "The title", content: "The content"
    as_user
    render 'departments/pane', pane: pane
    rendered.should have_selector('button', text: 'Edit')
  end

  it "doesn't show an edit button if it's a guest" do
    d = Fabricate :department
    pane = d.homepage_docs.create title: "The title", content: "The content"
    as_guest
    render 'departments/pane', pane: pane
    rendered.should_not have_selector('button', text: 'Edit')
  end
    

end
