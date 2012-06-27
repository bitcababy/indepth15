def setup_section
	@the_teacher = Fabricate(:teacher)
	@the_course = Fabricate(:course)
	@the_section = Fabricate :section, course: @the_course, teacher: @the_teacher

  3.times { @the_section.add_assignment(Utils.future_due_date + rand(1..5), Fabricate(:assignment)) }
  2.times { @the_section.add_assignment(Utils.future_due_date - rand(1..5), Fabricate(:assignment)) }
end

##
## Givens
##
Given /^I go to its assignments page$/ do
	section = Section.last
	section.should_not be_nil
	section.teacher.should_not be_nil
	visit section_assignments_path(section)
end

Given /^that teacher teaches that section$/ do
	steps "Given that section belongs to that teacher"
end

Given /^the section has (\d+) future assignments$/ do |n|
	section = Section.last
	n.times { Fabricate(:future_section_assignment, section: section)}
end


Given /^the section has (\d+) past assignments$/ do |n|
	section = Section.last
	n.times { Fabricate(:past_section_assignment, section: section)}
end

Given /^that assignment is assigned to block "(.*?)"$/ do |block_name|
	assignment = Assignment.last
	section = Section.first.where(block: block_name)
	section.should_not be_nil
	
  pending # express the regexp above with the code you wish you had
end

##
## Whens
##

When /^I go to the assignments page of a section$/ do
	setup_section
	visit section_assignments_path(@the_section)
end

##
## Thens
##

Then /^I should see a title with the teacher's name, the academic year, and the block$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the teacher's general assignment comment$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the teacher's upcoming assignments comment$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the current assignment$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see upcoming assignments$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see (\d+) past assignments$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should be able to see more past assignments$/ do
  pending # express the regexp above with the code you wish you had
end

