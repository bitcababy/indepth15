class Document
	include Mongoid::Document
	include Mongoid::Paranoia
	include Mongoid::Versioning
  include Mongoid::Timestamps if Rails.env == 'production'

	field :dt, as: :type, type: Symbol, default: :unknown
	field :ma, as: :major_tags, type: Array, default: []
	field :mi, as: :minor_tags, type: Array, default: []
	
	belongs_to :owner, polymorphic: true
	
	ASSIGNMENT_TYPE = :assignment
	TYPES = [:assignment, :worksheet, :test, :quiz, :retake, :benchmark, :classwork, :homework]

end