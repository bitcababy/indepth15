def deduce_path(page_name)
	if @menu_name == 'Courses' then
		if Course.where(full_name: page_name).exists?
			course = Course.find_by(full_name: page_name)
			return course_path(course)
		elsif page_name =~ /Block ([A-H])$/
			course = Course.find_by(full_name: @course_name)
			section = Section.find_by(course: course, block: $1)
			section.should_not be_nil
			return assignments_page_path(section)
		else
			puts current_path
			pending "problem in course area of deduce_path for #{page_name}"
		end
	else
		puts current_path
		pending "Need to provide code for #{page_name}"
	end
end

Then /^I should go to the assignments page of that section$/ do
	expected_path = deduce_path(@item_name)
	current_path.should == expected_path
end

Then /^I should (?:visit|go to|see) the "([^"]+)" page$/ do |page_name|
	case page_name
	when "About"
		pending "Unfinished test"
	else
		expected_path = deduce_path(page_name)
	end
	current_path.should == expected_path
end

Given /^I am not on the home page$/ do
	visit about_path
end

Then /^I should go to the home page$/ do
	step /Then I should go to the "Home" page/
end

Then /^I should go to that course's page$/ do
	pending "Unfinished test"
end

