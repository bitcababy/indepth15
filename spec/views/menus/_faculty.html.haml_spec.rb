require 'spec_helper'

describe 'menus/_faculty' do
	it "displays a faculty list" do
		render partial: 'menus/faculty', locals: {teachers: []}
		expect(rendered).to have_selector('li.faculty') do |li|
			expect(li).to have_selector('a', href: '#', content: 'Faculty')
			expect(li).to have_selector('ul#faculty_menu')
		end
	end
end
