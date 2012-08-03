##
## Givens
##

Given /^the menu item "([^"]+)" exists$/ do |menu_item|
	page.should have_selector('#menubar a', title: menu_item)
end


# When /^I click the "(.*?)" menu item$/ do |menu_item|
# 	within('#menubar')
# 		case menu_item
# 		when "Sign in"
# 			pending "Unfinished test"
# 		  click_link 'Sign in'
# 		when "About"
# 			visit about_path
# 		when "Geometry Honors"
# 			course = Course.find_by(full_name: "Geometry Honors")
# 			course.should be_kind_of Course
# 			visit polymorphic_path(course)
# 		else
# 			pending "fill in #{menu_item} menu item click"
# 		end
# 	end
# end

When /^I click on "(.*?)" in the Courses menu$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end