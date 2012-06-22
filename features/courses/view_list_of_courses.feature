Feature: View list of courses
  In order to access a course
  As a guest
  I want to be able to view a list of courses which link to each course's home page

	Scenario: Courses page
		Given the following courses:
		 | number | full_name       |
		 | 1      | Geometry Honors |
		 | 2      | Math 101        |
	  When I got to the courses page
	  Then I should see a list of courses
