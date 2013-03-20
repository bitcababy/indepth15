require 'spec_helper'

describe "departments/_pane.html" do
  before do
    view.stub(:edit_dept_doc_path).and_return ""
  end

  it "displays one of the department's panes without an edit button" do
    pane = stub_model DepartmentDocument, title: "The title", content: "The content"
    as_guest do
      render 'departments/pane', pane: pane
      expect(rendered).to match pane.title
      expect(rendered).to match pane.content
      expect(page).to_not have_link 'Edit'
    end
  end
  
  it "shows an edit button iff the user is logged in" do
    pane = stub_model DepartmentDocument, title: "The title", content: "The content"
    as_user do
      render 'departments/pane', pane: pane
      expect(page).to have_link 'Edit'
    end
  end

end
