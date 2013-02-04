Feature: Panes
  In order to make navigation easy
  As a user
  I want panes with useful information
	
	Background:
		Given the following department:
		 | name | foobar |
		And that department has the following department_documents:
			| title | content |
			| Doc 1 | Contents of doc 1 |
			| Doc 2 | Contents of doc 2 |
  
	@javascript
  Scenario: initial state
    When I go to the home page
    Then I should see a pane titled "<title>" with contents "<contents>"
			| title | contents |
			| Doc 1 | Contents of doc 1 |
			| Doc 2 | Contents of doc 2 |
 			And pane 1 should be open

	@javascript
	Scenario: Click an inactive header
    When I go to the home page
			And I click on the title of pane 2
		Then pane 2 should be open 
			And pane 1 should be closed
