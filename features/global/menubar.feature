Feature: Menubar

	Background:
		When I visit any page
	
  Scenario: The menubar
		Then I should see a menubar with a menu named "<name>":
			| name |
			| Home |
			| Courses |
			| Teachers |

	Scenario: The course menu
		When I click on the "Courses" menu
		Then I should see all courses in the catalog
		And I should see all sections of each course

	Scenario: The teachers menu
		When I click on the "Teachers" menu
		Then I should see all current teachers
  
	Scenario: Clicking on a course
		When I click on a course name
		Then I should go to the course's home page
	
	Scenario: Clicking on a teacher's name
		When I click on a teacher
		Then I should go to the teacher's home page

	Scenario: Clicking on a section
		When I click on a section
		Then I should go to the assignments page of that section
