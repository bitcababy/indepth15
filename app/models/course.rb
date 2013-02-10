class Course
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable
  
	FULL_YEAR = :full_year
	FULL_YEAR_HALF_TIME = :halftime
	FIRST_SEMESTER = :first_semester
	SECOND_SEMESTER = :second_semester

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
  field :oc, as: :occurrences, type: Array
  field :mt, as: :major_tags, type: Array
  
	field :_id, type: Integer, default: ->{ number }
  
  track_history except: [:number], track_create: true
 	##
	## Associations
	##
	has_many :sections do
    def current
      @target.select {|s| s.academic_year == Settings.academic_year}
    end
  end

  embeds_many :documents, class_name: 'CourseDocument'
  belongs_to :department, index: true

	##
	## Scopes
	##
	scope :in_catalog, where(in_catalog: true).asc(:number)
  
  def doc_of_kind(k)
    return self.documents.where(kind: k).first
  end

	def sorted_sections
		sections = self.sections.current
		return sections.sort do |a, b|
			teacher_a = a.teacher
			teacher_b = b.teacher
			if teacher_a == teacher_b 
				 a.block <=> b.block
			elsif teacher_a.last_name == teacher_b.last_name
				return teacher_a.first_name <=> teacher_b.first_name
			else
				teacher_a.last_name <=> teacher_b.last_name
			end
		end
	end
	
	# def teachers
	# 	(self.current_sections.map &:teacher).uniq
	# end
		
	def menu_label
		self.full_name
	end
  
  def create_docs
    self.course_documents.create kind: :resources
    self.course_documents.create kind: :news
    self.course_documents.create kind: :policies
    self.course_documents.create kind: :information
    self.course_documents.create kind: :description
    
    self.save!
  end
  
end
