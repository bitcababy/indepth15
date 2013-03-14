require 'spec_helper'

describe 'assignments/new' do
  before do
    stub_template 'assignments/_form' => "form"
  end
  
  it "displays as if it were a widget" do
    render
    expect(rendered).to have_selector '#new_assignment.ui-widget.ui-corner-all'
    expect(rendered).to have_selector '.ui-widget-header', text: "New assignment"
    expect(rendered).to have_selector '.ui-widget-content'
  end
  
end
