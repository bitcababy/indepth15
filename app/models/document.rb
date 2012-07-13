class Document
	include Mongoid::Document
	field :mj, as: :major_version, type: Integer, default: 1
	field :mi, as: :minor_version, type: Integer, default: 0
	
	belongs_to :owner, polymorphic: true
	has_and_belongs_to_many :tags, inverse_of: nil

	def bump_minor_version
		self.minor_version += 1
	end
	
	def bump_major_version
		self.major_version += 1
	end

	TYPES = [:assignment, :worksheet, :test, :quiz, :retake, :benchmark, :classwork, :homework]

end