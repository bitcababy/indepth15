Feature: View list of courses
  In order to access a course
  As a guest
  I want to be able to view a list of courses which link to each course's home page

	Scenario: Courses page
		Given the following courses:
		 | number | full_name          |
		 | 2      | Mechanical drawing |
		 | 1      | Geometry Honors    |
		 | 3      | Math 101           |
	  When I go to the courses page
	  Then I should see this list:
		 | item               |
		 | Geometry Honors    |
		 | Mechanical drawing |
		 | Math 101           |
