require 'spec_helper'

describe 'menus/_faculty' do
	it "displays a faculty list" do
    stub_template 'menus_teacher' => "teachers menu"
		render partial: 'menus/faculty', locals: {teachers: []}
		expect(rendered).to have_selector('li.faculty')
    li = page.find('li.faculty')
		expect(li).to have_link('Faculty', href: "#")
		expect(li).to have_selector('ul#faculty_menu')
	end
end
