Feature: Settings
  In order to manage settings
  As a developer
  I want to be able to get and set named values easily

	Scenario: Set a value for a name
		

	Scenario Outline: Get a setting
	  Given the following settings
		 | name          | value |
		 | academic_year | 2012  |
		 | cutoff.hour   | 15    |
		 | cutoff.minute | 30    |
	  When I get the value of "<name>"
	  Then I should get <the result>
		
		Examples: Valid examples
		 | name          | the result        |
		 | academic_year | returns 2012 |
		 | cutoff.hour   | returns 15   |
		 | cutoff.minute | returns 30   |
		Examples: Invalid examples
		 | name | the result |
		 |      | an error   |
		 | foo  | an error   |
	
		
