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

	@javascript
	Scenario: Clicking a course name
		Given there is a "Geometry Honors" item in the "Courses" menu
		When I click on it
		Then I should go to the "Geometry Honors" page

  @javascript
	Scenario: Clicking on a section
		Given there is a "Geometry Honors" item in the "Courses" menu
			And it has a "Mr. Gabriner, Block E" subitem
	  When I click on it
	  Then I should go to the assignments page of that section
	
	
	
