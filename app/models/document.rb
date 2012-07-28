class Document
	include Mongoid::Document
	include Mongoid::Paranoia
  # include Mongoid::Timestamps

	field :dt, as: :document_type, type: Symbol
	field :ma, as: :major_tags, type: Array, default: []
	field :mi, as: :minor_tags, type: Array, default: []
	
	belongs_to :owner, polymorphic: true
		
	TYPES = [:assignment, :worksheet, :test, :quiz, :retake, :benchmark, :classwork, :homework]

end