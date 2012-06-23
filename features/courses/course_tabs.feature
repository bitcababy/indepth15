Feature: Course home page
	This page provides everything available about a course. Rather than use separate pages,
	we use a tabbed interface to make things simpler.
	
	Background:
		When I go to a course's home page
	
	Scenario: Page header
		Then the page header should contain the full name of the course
		
	Scenario: Tabs
		Then I should see the following tabs:
			 | tab         |
			 | Sections    |
			 | Information |
			 | Resources   |
			 | Policies    |
			 | News        |
			
	Scenario: Section table
		Then I should see a sections table
	
