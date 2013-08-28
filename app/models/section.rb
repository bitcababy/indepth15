class Section
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  CURRENT_VERSION = 2

  field :bl, as: :block, type: String
  validates :block, presence: true, length: { minimum: 1, maximum: 2 }


  field :du, as: :duration
  # validates :duration, presence: true, inclusion: { in: Course::DURATIONS }

  field :se, as: :semester#, type: Symbol
  validates :semester, inclusion: { in: Durations::SEMESTERS }, allow_nil: true

  field :mv, as: :model_version, type: Integer

  field :eb, as: :extended_block, type: String, default: -> { "#{block}#{Durations.semester_to_i(semester)}"}

  field :y, as: :year, type: Integer
  validates :year, presence: true, numericality: { only_integer: true, less_than_or_equal_to: Settings.academic_year + 1}

  field :days, type: Array, default: (1..5).to_a
  field :rm, as: :room, type: String, default: ""

  has_many :section_assignments, dependent: :destroy, autosave: true
  belongs_to :course, index: true, autosave: true
  belongs_to :teacher, index: true, autosave: true

  validates :course_id, presence: true
  validates :teacher_id, presence: true

  field :_id, default: -> { "#{year%100}-#{course_id}-#{teacher_id}-#{extended_block}"}

  validates_uniqueness_of :block, scope: [:course_id, :teacher_id, :year, :semester]
  validates_uniqueness_of :teacher_id, scope: [:course_id, :block, :year, :semester]

  scope :current,               -> { where(year: Settings.academic_year) }
  scope :for_block,             ->(b) { where(block: b) }
  # scope :for_first_semester,    ->{ where(semester: Durations::FIRST_SEMESTER) } 
  # scope :for_second_semester,    ->{ where(semester:Durations::SECOND_SEMESTER) }
  # scope :for_semester,          ->(s){ (s == Course::FIRST_SEMESTER) ? for_first_semester : for_second_semester }
  scope :for_year,              ->(y) { where(year: y) }
  scope :for_course,            ->(c){ where(course: c) }
  scope :for_teacher,           ->(t){ where(teacher: t) }

  # delegate :major_topics, to: :course
  if Rails.env.test?
    delegate :department, to: :course, allow_nil: true
  else
    delegate :department, to: :course
  end

  track_history track_create: false

  before_save :sync_with_sas

  def clone(save: true, delete: false)
    attrs = self.attributes
    attrs[:model_version] = CURRENT_VERSION
    sec = self.class.new attrs
    return self if Section.where(_id: sec._id).exists?
    self.section_assignments.each {|sa| sa.section = sec}
    self.delete if delete
    sec.save! if save
    return sec
  end

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
    return "#{self.year}/#{self.course.to_param}/#{self.teacher.login}/#{self.block}/#{semester}"
  end

  def label_for_teacher
    return "#{self.course.short_name || self.course.full_name}, Block #{self.block}"
  end

  def menu_label
    return "#{self.teacher.formal_name}, Block #{self.block}"
  end

  def upcoming_assignments
    return self.future_assignments - self.current_assignments
  end

  def current_assignments
    if na = self.future_assignments.assigned.limit(1).first
      return self.section_assignments.due_on(na.due_date).includes(:assignment)
    else
      return []
    end
  end

  def future_assignments
    return self.section_assignments.future.asc(:due_date).includes(:assignment)
  end

  def past_assignments
    return self.section_assignments.past.desc(:due_date).includes(:assignment)
  end

  def page_header
    "#{course.full_name}, Block #{self.block}"
  end

  class << self
    def retrieve(year: Settings.academic_year, teacher: nil, course: nil,
                 limit: nil, block: nil, order: {}
                 )
      return [] unless year || teacher || course
      crit = self.includes(:assignment)
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
