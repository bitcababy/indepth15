class Course
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::History::Trackable
  
  # before_create :add_major_topics
  
	FULL_YEAR = 12
	FULL_YEAR_HALF_TIME = 3
	FIRST_SEMESTER = 1
	SECOND_SEMESTER = 2

	DURATIONS = [ FULL_YEAR, FIRST_SEMESTER, SECOND_SEMESTER, FULL_YEAR_HALF_TIME ]
	SEMESTERS = [ FIRST_SEMESTER, SECOND_SEMESTER ]
	MAJOR_TOPIC_MAP = {
		'Geometry' => [
			'Transformations', 'Similarity', 'Congruence', 'Logic/Proof',
			'Measurement', 'Non-Euclidean', 'Circles', 'Polygons', 'Parallel Lines'
			],
		'Algebra' => [
			'Functions',
			'Quadratics',
			'Exponents/Logs',
			'Systems of Equations',
			'Number Theory',
			'Probability/Combinatorics',
			'Data Distributions',
			'Correlation/Regression',
		],
		'Precalculus' => [
			'Functions',
			'Trigonometry',
			'Probability/Combinatorics',
			'Complex Numbers',
			'Polynomials',
			'Iteration',
			'Rational Functions',
			'Logic/Proof',
			'Number Theory',
		],
		'Calculus' => [
			'Limits',
			'Sequences/Series',
			'Derivatives',
			'Integrals',
			],
		'Statistics' => [
			'Data Distributions',
			'Data Collection',
			'Sampling Distributions',
			'Inference',
			'Correlation/Regression',
			],
		'Discrete Math' => [
			'Inference',
			'Data Collection',
			'Queueing Theory',
			'Manhattan Metric',
			'Game Theory',
			'Graph Theory',
			'Emergence',
			'Risk Analysis',
			],
	}
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

	##
	## Fields
	##
	field :no, as: :number, type: Integer
	validates :number, presence: true, uniqueness: true, numericality: {only_integer: true}
  
	field :du, as: :duration, default: FULL_YEAR
	validates :duration, presence: true, inclusion: {in: DURATIONS}
	
	field :cr, as: :credits, type: BigDecimal, default: 5.0
	validates :credits, presence: true, numericality: true, inclusion: Settings.credits
	
	field :fn, as: :full_name, type: String, default: ""
	validates :full_name, presence: true, length: { minimum: 3 }

	field :sn, as: :short_name, type: String, default: ->{ full_name }
	field :sc, as: :schedule_name, type: String, default: ->{ full_name }

	field :ha, as: :has_assignments, type: Boolean, default: true
  field :oc, as: :occurrences, type: Array
  
  field :ic, as: :in_catalog, type: Boolean, default: true
  
	field :_id, type: String, default: ->{ number }

  index( {number: -1} )
  
  scope :in_catalog, where(in_catalog: true)

 	##
	## Associations
	##
	has_many :sections, autosave: true do
    def for_teacher(t)
      where(teacher: t)
    end
    def current
      @target.select {|section| section.current? }
    end
  end

  belongs_to :department
  has_and_belongs_to_many :major_topics, autosave: true

  embeds_many :documents, class_name: 'CourseDocument'
  
	##
	## Scopes
	##
	# 
	
  track_history except: [:number]
  
  def <=>(c)
    self.number <=> c.number
  end

  def to_s
    self.full_name
  end
  
  def teachers
    return (sections.map &:teacher).uniq
  end
  
  def current_teachers
    return teachers.select {|t| t.current}
  end

  def current?
    return self.sections.limit(1).where(year: Settings.academic_year).exists?
  end

  def branches
    BRANCH_MAP[self.number].to_a
  end

  def add_major_topics
    return unless self.branches
    topics = (self.branches.collect {|b| MAJOR_TOPIC_MAP[b]}).flatten
    topics.uniq!
    mts = topics.collect { |topic| MajorTopic.find_or_create_by name: topic }
    self.major_topics = mts
  end

  def doc_of_kind(k)
    return self.documents.where(kind: k).first
  end

	def sorted_sections
		return self.sections.current.sort
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
