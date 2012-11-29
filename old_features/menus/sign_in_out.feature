@anypage
Feature: Home link
  In order to be able to log in and out
  As a user
  I want something to click to do so

	Scenario: Click on sign in
		Given I am not signed in
	  When I click the "Sign in" menu item
			And I fill in 

	Scenario: Click the 'About' item
	  When I click the "About" menu item	
	  Then I should go to the "About" page
	
	
