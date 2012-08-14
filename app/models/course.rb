class Course
  include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'

	FULL_YEAR = :full_year
	FULL_YEAR_HALF_TIME = :halftime
	FIRST_SEMESTER = :first_semester
	SECOND_SEMESTER = :second_semester

	BRANCH_MAP = {
		321 => 'Geometry',
		322 => 'Geometry',
		326 => 'Algebra',
		331 => 'Algebra',
		332 => 'Algebra',
		333 => 'Algebra',
		341 => 'Precalculus',
		342 => ['Precalculus', 'Statistics', 'Algebra'],
		343 => 'Discrete Math',
		352 => 'Precalculus',
		361 => 'Calculus',
		371 => 'Calculus',
		391 => 'Statistics',
	}

	DURATIONS = [FULL_YEAR, FIRST_SEMESTER, SECOND_SEMESTER, FULL_YEAR_HALF_TIME]
	SEMESTERS = [FIRST_SEMESTER, SECOND_SEMESTER]

	##
	## Fields
	##
	field :no, as: :number, type: Integer
	validates :number, presence: true, uniqueness: true

	field :du, as: :duration, type: Symbol, default: FULL_YEAR
	validates :duration, presence: true, inclusion: {in: DURATIONS}
	
	field :cr, as: :credits, type: BigDecimal, default: 5.0
	validates :credits, presence: true, numericality: true
	
	field :fn, as: :full_name, type: String, default: ""
	validates :full_name, presence: true

	field :sn, as: :short_name, type: String, default: ""
	field :sc, as: :schedule_name, type: String, default: ""

	field :ha, as: :has_assignments, type: Boolean, default: true
	field :ic, as: :in_catalog, type: Boolean, default: true
	field :de, as: :description, type: String, default: ""

	field :info, as: :information, type: String, default: ""
	field :res, as: :resources, type: String, default: ""
	field :pol, as: :policies, type: String, default: ""
	field :news, type: String, default: ""
	
	field :_id, type: Integer, default: ->{ number }
	
	index( {number: 1}, {unique: true} )
	
	##
	## Associations
	##
	has_many :sections

	has_and_belongs_to_many :major_tags, inverse_of: nil
	has_and_belongs_to_many :branches

	##
	## Scopes
	##
	scope :in_catalog, where(in_catalog: true).asc(:number)

	def current_sections
		return self.sections.current
	end
	
	# def teachers
	# 	(self.current_sections.map &:teacher).uniq
	# end
		
	def menu_label
		self.full_name
	end
	
	class << self
		SEMESTER_MAP = {
			12 => FULL_YEAR,
			1 => FIRST_SEMESTER,
			2 => SECOND_SEMESTER,
			3 => FULL_YEAR_HALF_TIME,
		}
		
		def import_from_hash(hash)
			hash[:duration] = SEMESTER_MAP[hash.delete(:semesters).to_i]
			course = self.create! hash
			return course
		end
	end

end
