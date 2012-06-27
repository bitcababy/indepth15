require 'spec_helper'

def check_assts(node, sas)
	for sa in sas do
		node.should have_selector('table', id: 'display') do |tbl|
			tbl.should have_selector('td', text: sa.name)
			tbl.should have_selector('td', text: assignment_date_string(sa.due_date))
			tbl.should have_selector('td', text: sa.contents)
		end
	end
end

describe AssignmentTableCell do
  context "cell rendering" do
		before do
	 		section = Fabricate(:section)
			3.times {|n| section.add_assignment(Utils.future_due_date + n, Fabricate(:assignment)) }
			@sas = section.section_assignments.asc(:date_due)
			@sas.count.should == 3
  	end

		it "should render a caption if one is provided" do
			res = render_cell(:assignment_table, :display, @sas, "@tbl", "Assignments")
			res.should have_selector('caption', text: 'Assignments')
		end

		it "should not display a caption if one isn't provided" do
			res = render_cell(:assignment_table, :display, @sas)
			res.should_not have_selector('caption')
		end
			
		it "should display the table headings" do
			res = render_cell(:assignment_table, :display, @sas, "@tbl", "Assignments")
			['#', 'Date due', 'Assignment'].each {|txt| res.should have_selector('th', text: txt)}
		end

		it "should display each assignment in a row" do
			res = render_cell(:assignment_table, :display, @sas)
			check_assts(res, @sas)
		end
  end


  context "cell instance" do 
    subject { cell(:assignment_table) } 
    
    it { should respond_to(:display) }
    
  end
end
