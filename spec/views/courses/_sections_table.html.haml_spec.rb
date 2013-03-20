require 'spec_helper'

describe 'courses/_sections_table' do

  it "creates a table of a courses sections" do
    course = stub_model Course
    stub_template 'courses/_section_table_row' => "A row"
    render partial: 'courses/sections_table', locals: {course: course}
    expect(rendered).to have_selector('table#sections_table thead tr')
    %W(block teacher room).each do |hdr|
      expect(rendered).to have_selector("th.#{hdr}")
    end
  end
		
end


	