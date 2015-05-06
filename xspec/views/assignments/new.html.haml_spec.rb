require 'spec_helper'

describe 'assignments/new' do
  it "contains a form" do
    stub_template 'assignments/_form' => "<form></form>"
    render
    expect(page).to have_selector 'form'
  end
  
end
