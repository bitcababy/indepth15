When /^I go to the assignments page of a section$/ do
	the_section = Fabricate(:section)
  3.times { the_section.add_assignment(Fabricate(:assignment), Date.today + rand(1..5)) }
  2.times { the_section.add_assignment(Fabricate(:assignment), Date.today - rand(1..5)) }
	visit section_assignments_path(the_section)
end

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

