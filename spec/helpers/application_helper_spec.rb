# encoding: UTF-8

require 'spec_helper'

describe ApplicationHelper do
	include MenuItemHelper

	describe '#academic_year_string' do
		it "returns a string for the full academic year" do
			academic_year_string(2012).should == "2011—2012"
		end
	end
	
	describe '#assignment_date_string' do
		it "returns the dotw, followed by the month and day" do
			assignment_date_string(Date.new(2012, 7, 12)).should == "Thu, Jul 12"
		end
	end
	
	describe '#link_for_menu_item' do
		context "with explicit link" do
			it "returns the link" do
				item = item_with_link link: "http://google.com"
				link_for_menu_item(item).should == "http://google.com"
			end
		end

		context "with action" do
			it "returns a link using the controller and action" do
				item = item_with_controller controller: 'courses', action: 'index'
				link_for_menu_item(item).should == '/courses'
			end
		end
				
		context "with object" do
			it "returns a link from the object" do
				obj = Fabricate(:course)
				item = Fabricate(:menu_item)
				item.object = obj
				link_for_menu_item(item).should == "/courses/#{obj.id}"
			end
		end

	end	
			
end

	