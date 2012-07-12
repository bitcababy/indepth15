@teacher
Feature: Section editor
  In order to make it easy to create/edit a section
  As a department head
  I want the teachers to do it themselves

	Background:
		Given the following course:
			| number | 321 |
			And it's the first semester
	
	Scenario: Creating a new section
	  When I go to create a new section for that course
		Then the section number should be blank
			And the semester should be the first semester
			And no block should be chosen
			And all occurrences should be checked
			And my default room should be entered
			
	Scenario: Description of form
		When I go to edit a section for that course
	  Then I should be able to enter a section number
			And I should be able to pick a semester
			And I should be able to pick a block
			And I should be able to enter the occurrences
			And I should be able to enter a room
			And I should be able to save the section
			And I should be able to reset the form
			And I should be able to cancel
			

	
	# 
	# Scenario: Conflicting section numbers
	# 	Given the following section:
	# 	 | number | block |
	# 	 | 1      | B     |
	# 	And I change the section number to "1"
	# 	Then I should see an error message
	# 	
		