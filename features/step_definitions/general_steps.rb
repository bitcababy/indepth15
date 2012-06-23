Then /^I should see a "([^"]*)" tab$/ do |tab_name|
	page.should have_selector("div#tabs ul"), "Expected a div with id tabs and a ul"
	page.find('div#tabs ul').should have_link tab_name#, "Expected a link named #{tab_name}"
end

Then /^the page title should be "([^"]*)"$/ do |title|
	pending "Unfinished test"
end
