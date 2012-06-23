Feature: Section assignments
  
	Scenario: Page overview
	  When I go to the assignments page of a section
	  Then I should see a title with the teacher's name, the academic year, and the block
		And I should see the teacher's general assignment comment
		And I should see the teacher's upcoming assignments comment
		And I should see the current assignment
		And I should see upcoming assignments
		And I should see 2 past assignments
		And I should be able to see more past assignments
