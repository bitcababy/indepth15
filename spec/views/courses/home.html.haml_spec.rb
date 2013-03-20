require 'spec_helper'

describe 'courses/home' do
  before do
    @course = stub_model Course, full_name: "Fractals 101"
		assign(:course, @course)
  end
    
	it "shows various tabs" do
		render
		expect(page).to have_selector('#tabs ul')
    tabs_ul = page.find('#tabs ul')
		for tab_name in %W(Sections Information Resources Policies News) do
			expect(tabs_ul).to have_selector('li', text: tab_name)
		end
	end

  it "shows the assignments tab if a section is provided" do
    section = stub_model Section, block: "B"
    assign(:section,section)
    render
    expect(page).to have_selector('li#assignments', 
      text: "Assignments for #{@course.full_name}, Block #{section.block}")
  end
end
