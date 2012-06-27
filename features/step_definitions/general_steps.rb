##
## Givens
##
Given /^I've visited a page$/ do
  pending # express the regexp above with the code you wish you had
end

##
## Whens
##
When /^I visit any page$/ do
  visit root_path
end

##
## Then
##
Then /^I should see a "([^"]*)" tab$/ do |tab_name|
	page.should have_selector("div#tabs ul"), "Expected a div with id tabs and a ul"
	page.find('div#tabs ul').should have_link tab_name#, "Expected a link named #{tab_name}"
end

Then /^the page title should be "([^"]*)"$/ do |title|
	pending "Unfinished test"
end

Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
end