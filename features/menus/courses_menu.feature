@anyone
Feature: Courses menu
  In order to get to a specific course or section
  As a user
  I want a menu item that gets me there

	Background:
		Given the following course:
		 | full name | Geometry Honors |
		 | number    | 321             |
		And the following teacher:
		 | honorific | Mr.      |
		 | last name | Gabriner |
		And the following section:
		 | block   | E            |
		 | teacher | Mr. Gabriner |
		 | course  | 321          |
		And I am on any page

		@showme
	Scenario: Clicking a course name
		When I click on "Geometry Honors" in the "Courses" menu
		Then I should go to the "Geometry Honors" home page

  
