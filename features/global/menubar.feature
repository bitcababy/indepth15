Feature: Menubar

	Background:
		When I visit any page
	
  Scenario: The menubar
		Then I should see a menubar 
		And the menubar should have a menu named "<name>":
		 | name     |
		 | Home     |
		 | Courses  |
		 | Teachers |


	# Scenario: The teachers menu
	# 	When I click on the "Teachers" menu
	# 	Then I should see all current teachers
	#   
