require 'spec_helper'

describe 'sections/_assignment_table' do
	it "display a table with the provided assignments" do
		sas = []
		(1..3).each do |i|
			sas << Fabricate(:section_assignment, assignment: Fabricate(:assignment), due_date: (Date.today + i))
		end
		assign(:table_id, "Upcoming")
		render partial: 'sections/assignment_table', locals: { assignments: sas }
		rendered.should have_selector('table', id:'Upcoming') do |tbl|
			tbl.should have_selector('thead tr')
		end
	end
		
end
