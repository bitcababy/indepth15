When /^I go to a teacher's home page$/ do
	the_teacher = Fabricate(:teacher)
	visit teacher_home_page_path(the_teacher)
end

When /^that teacher "(.*?)" has a personal website$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a picture of the teacher$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^a list of the courses currently taught by that teacher$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^a link to that teacher's email$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^a link to that teacher's schedule$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a link to that website$/ do
  pending # express the regexp above with the code you wish you had
end

