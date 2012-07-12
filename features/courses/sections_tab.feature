Feature: Sections tab
  In order to view the sections of a course
  As a user
  I want to see a table of all the sections of the current semester

	Background:
		Given the following course:
			| number | 321 |
			And I'm viewing the sections pane of that course
			
	Scenario: Sections table
	  When the course has sections
	  Then I should see a section table

	Scenario: Adding a section
		Given I'm a teacher
	  Then I should see an "Add section" button
	
	Scenario: Editing a section
		Given I'm a teacher
  	When I'm teaching a section of course 321
	  Then I should see an "Edit" button in the row of that section
