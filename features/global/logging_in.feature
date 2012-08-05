Feature: Logging in
  In order to access registered user actions
  As a user
  I want to be able to log in

	Scenario: Selecting 'Sign in'
		Given I am not logged in
		  And I am on any page
	  When I click 'Sign in'
		  Then I should see a sign-in dialog
		When I enter a correct name and password and click 'Sign in'
		Then I see a successful sign in message
			
