Feature: User menubar

	Background:
		Given I visit any page
		
  Scenario: The menubar
		When I click on the "Home" menu link
		Then I should go to the home page

	Scenario: Teacher
		Given I'm signed in as a teacher
		When I visit any page
		# Then I should see a menubar with these menus:
		#  | name  |
		#  | Admin |


	# Scenario: The teachers menu
	# 	When I click on the "Teachers" menu
	# 	Then I should see all current teachers
	#   
