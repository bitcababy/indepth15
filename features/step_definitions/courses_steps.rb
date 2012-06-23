###
### Whens
###

When /^I go to a course's home page$/ do
	the_course = Fabricate(:course)
	get "courses/#{the_course.number}/home"
end

When /^I go to the courses page$/ do
	visit list_courses_path
end

###
### Thens
###
Then /^I should see this list:?$/ do |table|
	ul = page.find('#courses')
	names = (ul.all('li').map &:text).map &:strip
	(table.hashes.map &:values).flatten.should == names
end

Then /^the page header should contain the course's name$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the following tabs:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a sections table$/ do
  pending # express the regexp above with the code you wish you had
end

