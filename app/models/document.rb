class Document
	include Mongoid::Document

	has_and_belongs_to_many :tags, inverse_of: nil
	
	TYPES = [:assignment, :worksheet, :test, :quiz, :retake, :benchmark, :classwork, :homework]

end