###
### Whens
###

When /^I go to a course's home page$/ do
	the_course = Fabricate :course
	visit course_home_path(the_course)
end

When /^I go to the courses page$/ do
	visit list_courses_path
end

###
### Thens
###
Then /^I should see (?:this|the) list:?$/ do |table|
	ul = page.find('#courses')
	names = (ul.all('li').map &:text).map &:strip
	(table.hashes.map &:values).flatten.should == names
end

Then /^the page header should contain the full name of the course$/ do
	page.should have_selector('#page_header') do |hdr|
		hdr.should have_content(the_course.full_name)
	end
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

