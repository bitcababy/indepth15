require 'spec_helper'

describe 'sections/_assignment_set' do
  before do
    stub_template 'sections/_assignment_table' => "foo"
  end
	it "renders a table containing a set of assignments" do
		asst = mock('assignment') do
			stubs(:content).returns "Assignment content"
		end

		sa = mock('section_assignment') do
			stubs(:name).returns '21'
			stubs(:due_date).returns Date.new(2012, 7, 20)
			stubs(:assignment).returns asst
		end

		render partial: 'sections/assignment_set', 
				locals: {table_id: 'current', sas: [sa], message: "Message", title: 'Some assignments'}
		expect(rendered).to have_selector('div.assignment-block') do |div|
			expect(div).to contain('Some assignments')
		end
	end
end
