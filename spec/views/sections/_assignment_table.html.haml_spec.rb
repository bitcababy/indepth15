require 'spec_helper'

describe 'sections/_assignment_table' do
	it "display a table with the provided assignments" do
		render partial: 'sections/assignment_table', locals: {sas: []}
		rendered.should have_selector('thead tr') do |row|
			['#', 'Date due', 'Assignment'].each {|hdr| row.should have_selector('th', content: hdr)}
		end
	end
		
end
