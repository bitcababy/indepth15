# encoding: UTF-8

Feature: Section assignments
  
	Background:
		Given the following teacher:
			 | honorific   | Mr.                        |
			 | first_name  | John                       |
			 | last_name   | Smith                      |
			 | general_msg | General assignment comment |
			 | current_msg | Current assignment comment |
		And the following section:
			 | block   | B          |
			 | course  | Math 101   |
			 | number  | 1          |
			 | teacher | John Smith |
	# 	And I go to its assignments page
	# 
	# Scenario: Top stuff
	# 	Then I should see "Mr. Smith's 2011–2012 Assignments for Block B"
	# 	And I should see "General assignment comment"
	# 	And I should see "Current assignment comment"
	# 	
	# Scenario: Assignments
	# 	Given the section has 3 future assignments
	# 	And the section has 4 past assignments
	# 	Then I should see the current assignment
	# 	And I should see 2 upcoming assignments
	# 	And I should see 2 past assignments
	# 	And I should be able to see more past assignments
	# 
	# Scenario: Assignment display
	# 	Given the following assignment:
	# 	 | name    | 105         |
	# 	 | content | Final exame |
	# 	 | block | B |
	# 	And that assignment is due 6/13/2012
