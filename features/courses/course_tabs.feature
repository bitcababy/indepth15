Feature: Course home page
	This page provides everything available about a course. Rather than use separate pages,
	we use a tabbed interface to make things simpler.
	
	Scenario: Tabs
		When I go to a course's home page
		Then the page header should contain the course's name
		And I should see the following tabs:
			 | tab         |
			 | Sections    |
			 | Information |
			 | Resources   |
			 | Policies    |
			 | News        |
			 | Calendar    |
		And I should see a sections table
	
