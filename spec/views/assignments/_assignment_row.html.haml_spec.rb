require 'spec_helper'

describe 'assignments/_assignment_row' do
	it "display the name, due date, and content of an assignment" do
		txt = "This is an assignment"
		assignment = Fabricate :assignment, content: txt
		sa = Fabricate :section_assignment, section: Fabricate(:section), assignment: assignment, due_date: Date.new(2012, 7, 20), name: "21"
		render partial: 'assignments/assignment_row', locals: {assignment: sa}
		rendered.should have_selector('tr.assignment') do |row|
			row.should have_selector('td.name') { |cell| cell.should contain("21")} 
			row.should have_selector('td.due_date') { |cell| cell.should contain("Fri, Jul 20") }
			row.should have_selector('td.content') { |cell| cell.should contain(txt) }
		end
	end
end