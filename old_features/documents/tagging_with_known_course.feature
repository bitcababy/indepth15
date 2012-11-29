Feature: Tagging
  In order to be able to find and filter documents
  As a user
  I want a variety of tags assigned to documents

	Scenario: Creating a document that belongs to a course
		Given a course that belongs to a branch of mathematics
		When a user creates a document for that course
		Then that user should tag the document based on that branch
			
	Scenario: Creating a document from scratch
		When a user creates a document
		Then that user should choose a a branch of mathematics
			And that user should tag the document based on that branch
		
	Scenario: Tagging based on a branch
		Given a document that's been tagged with a branch
	   	And a user is tagging that document
		Then that user should be able to pick major tags from that branch
			And that user should be able to add new major tags for that branch
			And that user should be able to add minor tags
	
	Scenario: Tagging with no branch
		Given a document that hasn't been tagged with a branch
	   	And a user is tagging that document
		Then that user should be able to pick any major tag
			And that user should be able to add new major tags
			And that user should be able to add minor tags
	
	Scenario: Changing the branch

	Scenario: Deleting the branch


	
	
	
	
	
	
	
	
	
	

			
	