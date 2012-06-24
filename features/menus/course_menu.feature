Feature: Course menu
  In order to have easy access to the assignments of a course
  As a user
  I want to have as few clicks as possible take me to them

	Background:
		When I visit any page

	Scenario: The course menu
		When I click on the "Courses" menu
		Then I should see all courses in the catalog
		And I should see all sections of each course
	
	Scenario: Clicking on a course
		When I click on a course name
		Then I should go to the course's home page

	Scenario: Clicking on a teacher's name
		When I click on a teacher
		Then I should go to the teacher's home page

	Scenario: Clicking on a section
		When I click on a section
		Then I should go to the assignments page of that section
	

  
