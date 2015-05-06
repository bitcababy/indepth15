require 'spec_helper'


describe 'courses/_sections_table' do

  it "creates a table of a courses sections" do
    course = stub_model Course
    stub_template 'courses/_section_table_row' => "A row"
    render partial: 'courses/sections_table', locals: {course: course}
    table = page.find('table')
    %W(block teacher room).each do |hdr|
      expect(table).to have_selector("th.#{hdr}")
    end
  end
		
end


	