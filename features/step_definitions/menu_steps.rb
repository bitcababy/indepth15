##
## Givens
##

Given /^the menu item "(.*?)" exists$/ do |menu_item|
	page.should have_selector('#menubar a', title: menu_item)
end

Given /^there is a "(.*?)" item in the "(.*?)" menu$/ do |link_name, menu_name|
	@menu_name = menu_name
	@item_name = link_name
	div_id = menu_name.downcase + "_menu"
	@the_menu = page.find('ul', id: div_id)
	@the_menu.should have_selector('a', content: link_name)
end

Given /^it has a "(.*?)" subitem$/ do |item_name|
	case @menu_name
	when "Courses"
		@course_name = @item_name
		@item_name = item_name
	else
		pending "Unfinished test"
	end
end

When /^I click on it$/ do
	within @the_menu do
 		click_link @item_name
	end
end

When /^I click the "(.*?)" menu item$/ do |menu_item|
	within('#menubar') do
		case menu_item
		when "Sign in"
		  click_link 'Sign in'
			wait_for_ajax
		when "About"
			visit about_path
		when "Geometry Honors"
			course = Course.find_by(full_name: "Geometry Honors")
			course.should be_kind_of Course
			visit polymorphic_path(course)
		else
			pending "fill in #{menu_item} menu item click"
		end
	end
end

When /^I click on "(.*?)" in the "(.*?)" menu$/ do |item_name, menu_name|
	@menu_name = menu_name
	@item_name = item_name
	div_id = menu_name.downcase + "_menu"
	menu = page.find('ul', id: div_id)
	within menu do
		click_link item_name
	end
end

# When /^I click on "(.*?)" (?:in|of) the Courses menu$/ do |item_name, menu_name|
# 	@item_name = item_name
# 	menu = page.find('ul#courses_menu)
# 	within menu do
# 		click_link item_name
# 	end
# end	
# 
