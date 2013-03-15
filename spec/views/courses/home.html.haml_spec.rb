require 'spec_helper'

describe 'courses/home' do
	include CourseMockHelpers

	it "shows various tabs" do
  before do
    stub_template ('sections/_assignments_pane') =>  "Assignments pane"
    stub_template ('courses/_sections_pane') =>  "Sections pane"
    stub_template ('courses/_information_pane') =>  "Information pane"
    stub_template ('courses/_resources_pane') =>  "Resources pane"
    stub_template ('courses/_news_pane') =>  "News pane"
    stub_template ('courses/_policies_pane') =>  "Policies pane"

	it "shows various tabs" do
		course = mock do
      stubs(:full_name).returns "Fractals 101"
    end
		assign(:course, course)
		render
		expect(rendered).to have_selector('#tabs ul') do |ul|
			for tab_name in %W(Sections Information Resources Policies News) do
				expect(ul).to have_selector('li a', title: tab_name, content: tab_name)
			end
		expect(rendered).to have_selector('#tabs ul')
		for tab_name in %W(Sections Information Resources Policies News) do
			expect(rendered).to have_selector('#tabs ul li a', text: tab_name)
		end
	end
end
