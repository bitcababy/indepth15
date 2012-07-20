
class Document
	include Mongoid::Document
	field :mj, as: :major_version, type: Integer, default: 1
	field :mv, as: :minor_version, type: Integer, default: 0
	field :dt, as: :document_type, type: Symbol
	field :ki, as: :kind, type: Symbol
	field :ma, as: :major_tags, type: Array, default: []
	field :mi, as: :minor_tags, type: Array, default: []
	
	belongs_to :owner, polymorphic: true
		
	def bump_minor_version
		self.minor_version += 1
	end
	
	def bump_major_version
		self.major_version += 1
	end

	TYPES = [:assignment, :worksheet, :test, :quiz, :retake, :benchmark, :classwork, :homework]

end