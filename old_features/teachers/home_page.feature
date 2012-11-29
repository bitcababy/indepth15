Feature: visiting a teacher's home page

	Scenario: What a teacher's home page should look like
		When I go to a teacher's home page
		Then I should see a picture of the teacher
		And a list of the courses currently taught by that teacher
		And a link to that teacher's email
		And a link to that teacher's schedule
		
	Scenario: See a teacher's personal website
		When that teacher "foo" has a personal website
		Then I should see a link to that website
