class Course
	include Export
	include Mongoid::Document
  include Mongoid::Timestamps
	
	NO_YEAR = -1
	
	FULL_YEAR = :full_year
	FIRST_SEMESTER = :first_semester
	SECOND_SEMESTER = :second_semester
	FULL_YEAR_HALF_TIME = :halftime
	DURATIONS = [FULL_YEAR, FIRST_SEMESTER, SECOND_SEMESTER, FULL_YEAR_HALF_TIME]
	BRANCH_MAP = {
		321 => 'Geometry',
		322 => 'Geometry',
		326 => 'Algebra',
		331 => 'Algebra',
		332 => 'Algebra',
		333 => 'Algebra',
		341 => 'Precalculus',
		342 => 'Precalculus',
		343 => 'Discrete Math',
		352 => 'Precalculus',
		361 => 'Calculus',
		371 => 'Calculus',
		391 => 'Statistics',
	}

	field :number, type: Integer
	field :academic_year, type: Integer, default: Settings.academic_year
	field :duration, type: Symbol, default: FULL_YEAR
	field :credits, type: BigDecimal, default: 5.0
	field :full_name, type: String, default: ""
	field :short_name, type: String, default: ""
	field :schedule_name, type: String, default: ""
	field :in_catalog, type: Boolean, default: true
	field :occurrences, type: Integer, default: 5
	field :has_assignments, type: Boolean, default: true

	scope :in_catalog, where(in_catalog: true).asc(:number)
	
	has_many :sections
	belongs_to :information_doc, class_name: 'CoursePage'
	belongs_to :resources_doc, class_name: 'CoursePage'
	belongs_to :policies_doc, class_name: 'CoursePage'
	belongs_to :news_doc, class_name: 'CoursePage'
	belongs_to :description_doc, class_name: 'CoursePage'

	has_and_belongs_to_many :course_tags, class_name: 'Tag::Course'
	has_and_belongs_to_many :major_tags, class_name: 'Tag::Major'
	belongs_to :branch, class_name: 'Tag::Branch'

	validates_uniqueness_of :number, scope: :academic_year
	
	def teachers
		(sections.collect {|s| s.teacher}).uniq
	end

	def clone_for_year(year)
		return if self.class.where(number: self.number, academic_year: year).exists?
		fields = self.attributes
		course = self.class.new fields
		course.academic_year = year
		course.save!
		course
	end

	SEMESTER_MAP = {
		12 => FULL_YEAR,
		1 => FIRST_SEMESTER,
		2 => SECOND_SEMESTER,
		3 => FULL_YEAR_HALF_TIME,
	}

	# class << self
	# 	def massage_hash(hash)
	# 		hash[:duration] = SEMESTER_MAP[hash[:semester].to_i]
	# 		# [:semester].each {|k| hash.delete(k)}
	# 	end
	# 
	# 	#
	# 	# importing
	# 	# 
	# 	def convert_record(hash)
	# 		hash['duration'] = SEMESTER_MAP[hash['semesters'].to_i]
	# 		info = hash['info']
	# 		resources = hash['resources']
	# 		policies = hash['policies']
	# 		prog_of_studies_descr = hash['prog_of_studies_descr']
	# 		%W(semesters info resources policies prog_of_studies_descr orig_id).each {|k| hash.delete(k)}
	# 		
	# 		course = self.create! hash
	# 		course_tag = Tag::Course.find_or_create_by(label: course.full_name)
	# 		doc = course.create_information_doc content: info
	# 		doc.tags << course_tag
	# 		branch_tag = BRANCH_MAP[course.number]
	# 		course.branch = Tag::Branch.find_or_initialize_by(label: branch_tag) if branch_tag
	# 		
	# 		course.create_resources_doc(content: resources)
	# 		course.create_news_doc
	# 		course.create_policies_doc content: policies
	# 		course.create_description_doc content: prog_of_studies_descr
	# 		course.academic_year = Settings.academic_year
	# 		course.save!
	# 		(Settings.academic_year - 1).downto(Settings.start_year) do |y|
	# 			course.clone_for_year y
	# 		end
	# 		course
	# 	end
	# end
	
end
	