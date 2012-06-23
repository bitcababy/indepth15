@javascript
Feature: Clicking on abs
	This page provides everything available about a course. Rather than use separate pages,
	we use a tabbed interface to make things simpler.
	
	Background:
	When I go to a course's home page
	
	Scenario: Click on Information tab
		When I click the "Information" tab
		Then I should see the information for the course
	
	Scenario: Click on Resources tab
		When I click the "Resources" tab
		Then I should see the resource information for the course
	
	Scenario: Click on News tab
		When I click the "News" tab
		Then I should see the news for the course
	
	Scenario: Click on Policies tab
		When I click the "Policies" tab
		Then I should see the policy information for the course
	
	Scenario: Click on Calendar tab
		When I click the "Calendar" tab
		Then I should see the calendar for the course
