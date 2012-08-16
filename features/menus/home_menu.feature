@anyone
Feature: Home link
  In order to be able to get back to the home page
  As a user
  I want something to click to get there

	Scenario: Clicking the home link
	  Given I am not on the home page
	  When I click the "Home" link
	  Then I should go to the home page
