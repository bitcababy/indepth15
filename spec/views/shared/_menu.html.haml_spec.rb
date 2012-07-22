require 'spec_helper'

describe 'shared/_menu' do
	include MenuItemHelper
	
	before :each do
		@menu = simple_menu label: "Menu 1", children: 3
		@menu.should have(3).child_menu_items
	end

	it "creates a list which contains its children" do
		render partial: 'shared/menu', locals: {menu: @menu}
		rendered.should have_selector('ul') do |ul|
			@menu.child_menu_items.each do |item|
				ul.should have_selector('li a') do |a|
					a.should contain(item.label)
				end
			end
		end
	end
	
	it "uses a class for the list" do
		@menu.menu_class = 'accordian'
		render partial: 'shared/menu', locals: {menu: @menu}
		rendered.should have_selector('ul', class: 'accordian')
	end
	
	it "uses 'sub-menu' if a class isn't provided" do
		render partial: 'shared/menu', locals: {menu: @menu}
		rendered.should have_selector('ul', class: 'sub-menu')
	end

end
