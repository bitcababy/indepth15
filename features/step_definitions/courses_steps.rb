
###
### Givens
###

Given /^(?:that )?I'm on the courses page$/ do
 steps %{
	When I go to the courses page
	}
end

###
### Whens
###

When /^I go to a course's home page$/ do
	the_course = Fabricate :course
	visit course_page_path(the_course)
end

When /^I go to the courses page$/ do
	visit courses_list_path
end

When /^I click on the tab labeled "([^"]+)"$/ do |label|
	click_link(label)
end

###
### Thens
###
Then /^I should see (?:this|the) list:?$/ do |table|
	ul = page.find('#courses')
	names = (ul.all('li').map &:text).map &:strip
	names.should == (table.hashes.map &:values).flatten
end

Then /^the page header should contain the full name of the course$/ do
	page.should have_selector('#page_header', content: the_course.full_name)
end

Then /^I should see the following tabs:$/ do |table|
	tab_names = (table.hashes.map &:values).flatten
	for tab in tab_names do
		steps %{
			Then I should see a "#{tab}" tab
		}
	end
end

Then /^I should see a sections table$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should switch to the "(.+)" pane$/ do |pane_name|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end


