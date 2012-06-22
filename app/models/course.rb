class Course
	include Mongoid::Document
	
	field :no, as: :number, type: Integer
	field :d, as: :duration, type: String, default: "Full year"
	field :c, as: :credits, type: BigDecimal, default: 5.0
	field :f, as: :full_name, type: String
	field :i, as: :in_catalog, type: Boolean, default: true
	field :a, as: :academic_year, type: Integer
	
	has_many :sections
		
	has_one :information, class_name: 'CourseDocument', autobuild: true
	has_one :description, class_name: 'CourseDocument', autobuild: true
	has_one :resources, class_name: 'CourseDocument', autobuild: true
	has_one :policies, class_name: 'CourseDocument', autobuild: true
	has_one :news, class_name: 'CourseDocument', autobuild: true
	
	validates_uniqueness_of :number

end
	