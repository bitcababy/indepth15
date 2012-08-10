require 'spec_helper'

describe 'sections/_assignment_row' do

	it "display the name, due date, and content of an assignment" do
		txt = "This is the content"
		asst = mock do
			stubs(:content).returns txt
		end

		sa = mock('section_assignment') do
			stubs(:name).returns "21"
			stubs(:due_date).returns Date.new(2012, 7, 20)
			stubs(:assignment).returns asst
		end

		render partial: 'sections/assignment_row', locals: {sa: sa}
		rendered.should have_selector('tr.assignment') do |row|
			row.should have_selector('td.name', content: "21") 
			row.should have_selector('td.due_date', content: "Fri, Jul 20")
			row.should have_selector('td.content', content: txt)
		end
	end
end
