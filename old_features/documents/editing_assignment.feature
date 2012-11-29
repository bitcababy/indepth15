Feature: Teacher creates new assignment
  In order to create a new assignment
  As a teacher
  I want to be able to click an 'add' button and fill out a form

	Background:
  	Given a course
  		And a teacher
			And an assignment for the course
	
	Scenario: Assignment editor
		When the edit form for the assignment open
	  Then the form should be filled out with the fields of the assignment
			And the course's major tags should be shown
			And save should be disabled
			And reset should be disabled
			
	Scenario: Save enabled
		When the edit form for the assignment open
	  When the content isn't empty
			And at least one section is published
			And all dates are valid
			And the assignment name is valid
			And at least one major tag is selected
	  Then the "Save" button should be enabled
	
		Scenario: Reset enabled
		  When any of the fields have been changed
			Then the reset button should be enabled
		
		Scenario: Reset clicked
		  When the reset button is clicked
		  Then the assignment should be reset to its original state
				And the form should reflect the assignment's new state
				
		Scenario: Bad date
			
		
		
					
			
		
		
		
		
	
	
	
	
	
	
	
	
