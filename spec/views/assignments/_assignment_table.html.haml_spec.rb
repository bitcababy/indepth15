require 'spec_helper'

describe 'assignments/_assignment_table' do
	it "display a table with the provided assignments" do
		sas = []
		(1..3).each do |i|
			section = Fabricate(:section)
			sas << Fabricate(:section_assignment, section: section, assignment: Fabricate(:assignment), due_date: (Date.today + i))
		end
		assign(:caption, "Upcoming message")
		assign(:table_id, "upcoming")
		render partial: 'assignments/assignment_table', locals: {assignments: sas}
		rendered.should have_selector('table', id: 'upcoming') do |table|
			table.should have_selector('thead tr') do |row|
				['#', 'Date due', 'Assignment'].each {|hdr| row.should have_selector('th', content: hdr)}
			end
		end
	end
		
end
