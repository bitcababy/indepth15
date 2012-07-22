require 'spec_helper'

describe 'shared/_menus' do
	include MenuItemHelper

	it "renders content for a menubar" do
		menus = []
		3.times { menus << simple_menu }
		for menu in menus do
			menu.child_menu_items.count.should > 0
		end
		render partial: 'shared/menus', locals: {menus: menus}
		rendered.should have_selector('ul') do |ul|
			for menu in menus do
				ul.should have_selector('li') {|li| li.should contain(menu.menu_label)}
			end
		end
		
		# view.content_for?(:menubar).should be_true
		# view.content_for(:menubar).should have_selector('ul') do |ul|
		# 	for menu in menus do
		# 		ul.should have_selector('li') {|li| li.should contain(menu.label)}
		# 	end
		# end
	end
	
	it "renders content for THE menubar" do
		menus = MenuSet.all_menus.menus
		render partial: 'shared/menus', locals: {menus: menus}
		rendered.should have_selector('ul#menubar') do |ul|
			for menu in menus do
				ul.should have_selector('li') {|li| li.should contain(menu.menu_label)}
			end
		end
		pending "Unfinished test"
	end
		

end
