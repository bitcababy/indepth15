Feature: Tabs
  In order to make navigation easy
  As a user
  I want tabs with useful information
  
  Scenario: Basic help
    When I go to the department page
    Then I should see a "<tabname>" tab
	 | tabname                           |
	 | How to use the new Westonmath App |
	 | Why not Teacherweb?               |
	 | Resources                         |
	 | News                              |
	 | Puzzle                            |
 
