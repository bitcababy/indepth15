Feature: Tabs
  In order to see various kinds of information about a course
  As a user
  I want an easy way to navigate between them
  
  Background:
  	Given a course
    When I visit that course's page
   
  Scenario: Tabs
    Then I should see a "<tabname>" tab
	 | tabname     |
	 | Sections    |
	 | Information |
	 | Resources   |
	 | Policies    |
	 | News        |

  Scenario: Sections tab
    When I click on the "Sections" tab
    Then I should see a brief description of that course
	And I should see a table containing all sections of that course
	
  Scenario: Information tab
  	When I click on the "Information" tab
	Then I should see the information for that course
	
  Scenario: Resources tab
  	When I click on the "Resources" tab
	Then I should see the resources for that course
	
  Scenario: Policies tab
  	When I click on the "Policies" tab
	Then I should see the policies of that course
	
  Scenario: News tab
  	When I click on the "News" tab
	Then I should see the news of that course

  
  
  