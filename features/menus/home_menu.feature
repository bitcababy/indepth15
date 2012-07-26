Feature: Home menu
  In order to have a place to dump things that don't go elsewhere
  As a developer
  I want a home menu ;)

	Background:
	  Given I've visited a page

	Scenario: Click on sign in
		Given I am not signed in
	  When I click the "Sign in" menu item
	  Then I should see a sign-in form

	Scenario: Click the 'About' item
	  When I click the "About" menu item	
	  Then I should go to the "About" page
	
	
	