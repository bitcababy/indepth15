require 'spec_helper'

describe 'sections/_assignment_table' do
	context "guest mode" do
  before do
    stub_template 'sections/_assignment_row' => "Section row"
  end
		it "display a table with the provided assignments" do
			render partial: 'sections/assignment_table', locals: {sas: []}
			expect(rendered).to have_selector('thead tr') do |row|
				['#', 'Date due', 'Assignment'].each {|hdr| expect(row).to have_selector('th', content: hdr)}
			end
		end
	end
		
end
