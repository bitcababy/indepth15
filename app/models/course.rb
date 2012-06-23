class Course
	include Mongoid::Document
	include Enumerable

	field :no, as: :number, type: Integer
	field :d, as: :duration, type: String, default: "Full year"
	field :c, as: :credits, type: BigDecimal, default: 5.0
	field :f, as: :full_name, type: String
	field :i, as: :in_catalog, type: Boolean, default: true
	field :a, as: :academic_year, type: Integer
	field :in, as: :information, type: String, default: ""
	field :de, as: :description, type: String, default: ""
	field :re, as: :resources, type: String
	field :n, as: :news, type: String, default: ""
	field :p, as: :policies, type: String, default: ""
	
	scope :in_catalog, where(in_catalog: true)
	
	has_many :sections
		
	validates_uniqueness_of :number, scope: :academic_year
	
	def <=> obj
		self.number <=> obj
	end
	
end
	