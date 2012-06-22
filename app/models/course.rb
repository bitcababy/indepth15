class Course
	include Mongoid::Document
	
	field :no, as: :number, type: Integer
	field :d, as: :duration, type: String, default: "Full year"
	field :c, as: :credits, type: BigDecimal, default: 5.0
	field :f, as: :full_name, type: String
	field :i, as: :in_catalog, type: Boolean, default: true
	field :a, as: :academic_year, type: Integer
	field :in, as: :information, default: ->{self.build_course_document}
	field :d, as: :description, default: ->{self.build_course_document}
	field :r, as: :resources, default: ->{self.build_course_document}
	field :p, as: :policies, default: ->{self.build_course_document}
	field :n, as: :news, default: ->{self.build_course_document}
	
	embeds_many :sections
	belongs_to :information, class_name: 'CourseDocument'
	belongs_to :description, class_name: 'CourseDocument'
	belongs_to :resources, class_name: 'CourseDocument'
	belongs_to :policies, class_name: 'CourseDocument'
	belongs_to :news, class_name: 'CourseDocument'
	
	validates_uniqueness_of :number

end
	