require 'spec_helper'

describe 'shared/_menu_item' do
	include MenuItemHelper
	describe "displaying one menu item" do
		before :each do
			@item = item_with_link label: "Google", link: "http://google.com"
		end

		it "uses the link for the url" do
			render partial: 'shared/menu_item', locals: {menu_item: @item}
			rendered.should have_selector('li a', href: "http://google.com")
		end
		
		it "creates the list item class" do
			@item.item_class = 'google'
			render partial: 'shared/menu_item', locals: {menu_item: @item}
			rendered.should have_selector('li', class: 'google')
		end

		it "creates the list item id" do
			@item.item_id = 'foo'
			render partial: 'shared/menu_item', locals: {menu_item: @item}
			rendered.should have_selector('li', id: 'foo')
		end

	end
	
end
