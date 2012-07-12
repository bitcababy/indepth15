Feature: User menubar

  Scenario: The menubar
		When I visit any page
		Then I should see a menubar with these menus:
		 | name     |
		 | Home     |
		 | Courses  |
		 | Faculty  |

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
