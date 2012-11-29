Feature: Saving an assignment
  In order to create a new assignment
  As a teacher
  I want to be able to click an 'add' button and fill out a form

	Background:
  	Given a course
  		And a teacher
			And an assignment for the course
			And the edit assignment form is displayed
	
	Scenario: Save enabled
	  When the content isn't empty
			And at least one section is published
			And all dates are valid
			And the assignment name is valid
			And at least one major tag is selected
	  Then the "Save" button should be enabled
	
	Scenario: Save disabled
	  When the form has "<state>"
		 | state                  |
		 | no content             |
		 | no major tags selected |
		 | no name                |
		 | an invalid date        |
		 | no section published   |
	  Then the "Save" button should be disabled
	
	
	
	
	