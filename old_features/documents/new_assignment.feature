Feature: New assignment
  In order to value
  As a role
  I want feature

	Background:
  	Given a course
  		And a teacher
	
	Scenario: New assignment
	 		When an assignment is added to a course
			Then the name should be the next name for the teacher's sections
				And the content should be empty
				And no major tag should be selected
				And no minor tags should be shown
				And the sections area should have the teacher's sections
				And the dates for the sections should be the next school day
				And all sections should be unpublished
