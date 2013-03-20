require 'spec_helper'

describe 'section_assignments/browse' do
  before do
    stub_template 'section_assignments/_row' => "A row"
  end
  
  it "display a table" do
    render
    pending "unfinished test"
    puts rendered.should have_selector('table')
  end
      
end
