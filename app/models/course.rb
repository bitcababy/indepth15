class Course
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

##
## Fields
##
	field :no, as: :number, type: Integer
	field :ay, as: :academic_year, type: Integer, default: Settings.academic_year
	field :du, as: :duration, type: Symbol, default: FULL_YEAR
	field :cr, as: :credits, type: BigDecimal, default: 5.0
	field :fn, as: :full_name, type: String, default: ""
	field :sn, as: :short_name, type: String, default: ""
	field :sc, as: :schedule_name, type: String, default: ""
	field :ic, as: :in_catalog, type: Boolean, default: true
	field :oc, as: :occurrences, type: Integer, default: 5
	field :ha, as: :has_assignments, type: Boolean, default: true

##
## Associations
##

	has_many :sections
	[:information_doc, :resources_doc, :policies_doc, :news_doc, :description_doc].each do |doc|
		has_one doc, class_name: 'Document::Text', inverse_of: :owner, autobuild: true, dependent: :destroy
	end

##
## Scopes
##
	scope :in_catalog, where(in_catalog: true).asc(:number)

##
## Validations
##
	validates_uniqueness_of :number, scope: :academic_year
	
	attr_accessor :information, :policies, :news, :resources, :description
	
	def information
		self.information_doc.content
	end
	
	def information=(txt)
		self.information_doc.content = txt
	end
	
	def resources
		self.resources_doc.content
	end
	
	def resources=(txt)
		self.resources_doc.content = txt
	end
	
	def resources
		self.resources_doc.content
	end
	
	def policies=(txt)
		self.policies_doc.content = txt
	end
	
	def news
		self.news_doc.content
	end
	
	def news=(txt)
		self.news_doc.content = txt
	end
	
	def description
		self.description_doc.content
	end
	
	def description=(txt)
		self.description_doc.content = txt
	end
	
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
	
	end

	class << self
		def import_from_hash(hash)
			hash[:duration] = SEMESTER_MAP[hash[:semesters].to_i]
			info = hash[:info]
			resources = hash[:resources]
			policies = hash[:policies]
			prog_of_studies_descr = hash[:prog_of_studies_descr]
			%W(semesters info resources policies prog_of_studies_descr).each {|k| hash.delete(k)}
			
			course = self.create! hash
			
			course.information = info
			course.resources = resources
			course.resources = resources
			course.policies = policies
			course.description = prog_of_studies_descr
			
			course.academic_year = Settings.academic_year
			course.save!
			(Settings.academic_year - 1).downto(Settings.start_year) do |y|
				course.clone_for_year y
			end
			course
		end
	end
	
		
end
	