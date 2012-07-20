require 'spec_helper'

describe 'shared/display_menus' do
	include MenuItemHelper

	it "display a list of menus" do
		menus = []
		3.times { menus << simple_menu }
		for menu in menus do
			menu.child_menu_items.count.should > 0
		end
		assign(:menus, menus)
		render
		rendered.should have_selector('ul') do |ul|
			for menu in menus do
				ul.should have_selector('li') {|li| li.should contain(menu.label)}
			end
		end
					
 end
end