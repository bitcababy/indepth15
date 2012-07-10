# encoding: UTF-8

Feature: Section assignments
  
	Background:
		Given the following section:
			 | block  | B        |
			 | course | Math 101 |
			 | number | 1        |
		And the following teacher:
			 | honorific      | Mr.                        |
			 | last_name      | Smith                      |
			 | general_leadin | General assignment comment |
			 | current_leadin | Current assignment comment |
		And that teacher teaches that section
		And I go to its assignments page

	Scenario: Top stuff
		Then I should see "Mr. Smith's 2011–2012 Assignments for Block B"
		And I should see "General assignment comment"
		And I should see "Current assignment comment"
		
	Scenario: Assignments
		Given the section has 3 future assignments
		And the section has 4 past assignments
		Then I should see the current assignment
		And I should see 2 upcoming assignments
		And I should see 2 past assignments
		And I should be able to see more past assignments


	Scenario: Assignment display
		Given the following assignment:
		 | name     | 105         |
		 | content | Final exame |
		And that assignment is assigned to block "B"		
		And that assignment is due 6/13/2012
		
	  