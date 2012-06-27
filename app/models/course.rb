class Course
	include Mongoid::Document

	field :no, as: :number, type: Integer
	field :d, as: :duration, type: Symbol, default: :full_year
	field :c, as: :credits, type: BigDecimal, default: 5.0
	field :f, as: :full_name, type: String
	field :i, as: :in_catalog, type: Boolean, default: true
	field :a, as: :academic_year, type: Integer
	field :in, as: :information, type: String, default: ""
	field :de, as: :description, type: String, default: ""
	field :re, as: :resources, type: String
	field :n, as: :news, type: String, default: ""
	field :p, as: :policies, type: String, default: ""
		
	scope :in_catalog, where(in_catalog: true).asc(:number)
	
	has_many :sections
	validates_uniqueness_of :number, scope: :academic_year
	
	def teachers
		(sections.collect {|s| s.teacher}).uniq
	end

end
	