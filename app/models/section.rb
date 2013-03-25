class Section
	include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::History::Trackable

  field :bl, as: :block, type: String
  validates :block, presence: true, length: { minimum: 1, maximum: 2 }

	field :du, as: :duration
	validates :duration, presence: true, inclusion: { in: Course::DURATIONS }
  
  field :eb, as: :extended_block, type: String, default: -> {
    case duration
     when Course::FIRST_SEMESTER
      "#{block}1"
    when Course::SECOND_SEMESTER
      "#{block}2"
    else
      block
    end
  }

  field :y, as: :year, type: Integer
  validates :year, presence: true, numericality: { only_integer: true, less_than_or_equal_to: Settings.academic_year + 1}
  
  field :days, type: Array, default: (1..5).to_a
	field :rm, as: :room, type: String, default: ""
  
	has_many :section_assignments, dependent: :delete, autosave: true
	belongs_to :course, index: true, autosave: true
	belongs_to :teacher, index: true, autosave: true

  validates_uniqueness_of :block, scope: [:course_id, :teacher_id, :year]
  validates_uniqueness_of :teacher_id, scope: [:course_id, :block, :year]

  scope :current,               -> { where(year: Settings.academic_year) }
  scope :for_block,             ->(b){ where(block: b[0]) }
  scope :for_first_semester,    ->{ where(:duration.in => [Course::FULL_YEAR, Course::FULL_YEAR_HALF_TIME, Course::FIRST_SEMESTER]) }
  scope :for_second_semester,   ->{ where(:duration.in => [Course::FULL_YEAR, Course::FULL_YEAR_HALF_TIME, Course::SECOND_SEMESTER]) }
  scope :for_semester,          ->(s){ (s == Course::FIRST_SEMESTER) ? for_first_semester : for_second_semester }
  scope :for_year,              ->(y) { where(year: y) }
  scope :for_course,            ->(c){ where(course: c) }
  scope :for_teacher,           ->(t){ where(teacher: t) }

  index({year: -1, course_id: 1, teacher_id: 1, block: 1})

  # delegate :major_topics, to: :course
  if Rails.env.test?
    delegate :department, to: :course, allow_nil: true
  else
    delegate :department, to: :course
  end

  track_history track_create: true
  
  before_save :sync_with_sas
  
  def sync_with_sas
    self.section_assignments.update_all(block: self.block, year: self.year, course_id: self.course_id, teacher_id: self.teacher_id)
  end
  
  def <=>(s)
    return self.year <=> s.year unless self.year == s.year
    return self.course <=> s.course unless self.course == s.course
    return self.teacher <=> s.teacher unless self.teacher == s.teacher
    return self.block <=> s.block unless self.block == s.block
    super
  end

  def current?
    self.year == Settings.academic_year
  end

	def to_s
		return "#{self.year}/#{self.course.to_param}/#{self.teacher.login}/#{self.block}/#{duration}"
	end

  def label_for_teacher
    return "#{self.course.short_name || self.course.full_name}, Block #{self.block}"
  end

  def label_for_course
    return "#{self.teacher.formal_name}, Block #{self.block}"
  end

	def upcoming_assignments
		return self.section_assignments.upcoming.asc(:due_date).assigned
	end

	def current_assignments
    if na = self.section_assignments.next_assignment.first
      return self.section_assignments.due_on(na.due_date).all.assigned
    else
      return []
    end
	end

	def future_assignments
		return self.section_assignments.future.asc(:due_date).assigned
	end

	def past_assignments(n=nil)
		ret = self.section_assignments.past.desc(:due_date).assigned
		n ? ret.limit(n) : ret
	end

	def page_header
		"#{course.full_name}, Block #{self.block}"
	end
  
  class << self
    def retrieve(year: Settings.academic_year, teacher: nil, course: nil,
      limit: nil, block: nil, order: {}
      )
      return [] unless year || teacher || course
      crit = self
      crit = crit.limit(limit) if limit
      crit = crit.without(:c_at, :u_at)
      crit = crit.for_year(year) if year
      crit = crit.for_course(course) if course
      crit = crit.for_teacher(teacher) if teacher
      crit = crit.for_block(block) if block
      crit = crit.order_by(order) unless order.empty?
      return crit 
    end
    
      
  end # class << self
		
end
