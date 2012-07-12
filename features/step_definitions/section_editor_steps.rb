##
## Givens
##
Given /^it's the first semester$/ do
  pending # express the regexp above with the code you wish you had
end

##
## Whens
##
When /^I go to create a new section for that course$/ do
	visit new_course_section_path(Course.first)
end

When /^I go to edit a section for that course$/ do
	visit edit_section_path(Fabricate(:section, course: Course.first))
end

##
## Thens
##
Then /^I should be able to enter a section number$/ do
	page.should have_selector('input', :name => 'section[number]')
end

Then /^I should be able to pick a semester$/ do
	page.should have_selector('input', :name => 'section[semester]')
end

Then /^I should be able to pick a block$/ do
	page.should have_selector('input', :name => 'section[block]')
end

Then /^I should be able to enter the occurrences$/ do
	page.should have_selector('input', :name => 'section[occurrences]')
end

Then /^I should be able to enter a room$/ do
	page.should have_selector('input', :name => 'section[room]')
end

Then /^I should be able to save the section$/ do
	page.should have_selector('input', id: 'section_submit')
end

Then /^I should be able to reset the form$/ do
	page.should have_selector('input', id: 'section_reset')
end

Then /^I should be able to cancel$/ do
	page.should have_selector('input', id: 'section_cancel')
end

Then /^the section number should be blank$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the semester should be the current semester$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^no block should be chosen$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^all occurrences should be checked$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^my default room should be entered$/ do
  pending # express the regexp above with the code you wish you had
end



