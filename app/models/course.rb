class Course
	include Export
	include Mongoid::Document
  include Mongoid::Timestamps
	
	NO_YEAR = -1
	
	FULL_YEAR = :full_year
	FIRST_SEMESTER = :first_semester
	SECOND_SEMESTER = :second_semester
	FULL_YEAR_HALF_TIME = :halftime
	
	field :number, type: Integer
	field :academic_year, type: Integer, default: NO_YEAR
	field :duration, type: Symbol, default: FULL_YEAR
	field :credits, type: BigDecimal, default: 5.0
	field :full_name, type: String
	field :short_name, type: String
	field :schedule_name, type: String
	field :in_catalog, type: Boolean, default: true
	field :occurrences, type: Integer, default: 5
	field :has_assignments, type: Boolean
	field :orig_id, type: Integer

	scope :in_catalog, where(in_catalog: true).asc(:number)
	
	has_many :sections
	belongs_to :information_doc, class_name: 'CoursePage'
	belongs_to :resource_doc, class_name: 'CoursePage'
	belongs_to :policies_doc, class_name: 'CoursePage'
	belongs_to :news_doc, class_name: 'CoursePage'
	belongs_to :description_doc, class_name: 'CoursePage'

	has_and_belongs_to_many :tags, inverse_of: nil

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

	class << self
		def massage_hash(hash)
			hash[:duration] = SEMESTER_MAP[hash[:semester].to_i]
			# [:semester].each {|k| hash.delete(k)}
		end
	
		#
		# importing
		# 
		def convert_record(hash)
			hash['duration'] = SEMESTER_MAP[hash['semester'].to_i]
			info = hash['info']
			resources = hash['resources']
			policies = hash['policies']
			prog_of_studies_descr = hash['prog_of_studies_descr']
			%W(semester info resources policies prog_of_studies_descr).each {|k| hash.delete(k)}
		
			course = self.new hash
			doc = course.create_information_doc content: info
			course.create_resource_doc content: resources
			course.create_news_doc
			course.create_policies_doc content: policies
			course.create_description_doc content: prog_of_studies_descr
			course.academic_year = Settings.academic_year
			course.save!
			(Settings.academic_year - 1).downto(Settings.start_year) do |y|
				course.clone_for_year y
			end
			course
		end
	end
	
end
	