Feature: View list of courses
  In order to access a course
  As a guest
  I want to be able to view a list of courses which link to each course's home page

	Background:
		Given the following courses:
		 | number | full_name          |
		 | 2      | Mechanical drawing |
		 | 1      | Geometry Honors    |
		 | 3      | Math 101           |
		
	Scenario: Courses, in course number order
	  When I go to the courses page
	  Then I should see this list:
		 | item               |
		 | Geometry Honors    |
		 | Mechanical drawing |
		 | Math 101           |

	Scenario: Clicking on a course
	  Given I'm on the courses page
	  When I click on a course name
	  Then I should go to the course's home page
		
		
		