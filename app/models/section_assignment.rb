class SectionAssignment
	include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::History::Trackable
  
	field :dd, as: :due_date, type: Date
	field :assigned, type: Boolean, default: false
  field :bl, as: :block, type: String
  field :ay, as: :academic_year, type: Integer
  
	index({due_date: -1, assigned: 1})
	
	belongs_to :section, counter_cache: true
	belongs_to :assignment, counter_cache: true
  belongs_to :course, index: true
  belongs_to :teacher, index: true
  
  delegate :name, :content, :content=, to: :assignment

  scope :for_year,          -> (y) { where(year: y) }
  scope :due_after,         ->(date){ gt(due_date: date) }
  scope :due_on_or_after,   ->(date) { gte(due_date: date) }
  scope :due_on,            ->(date){ where(due_date: date) }
  scope :due_before,        ->(date) { lt(due_date: date) }
  scope :assigned,          -> { where(assigned: true) }
  scope :past,              -> { due_before(future_due_date).assigned }
  scope :future,            -> { due_on_or_after(future_due_date ).assigned }
  scope :next_assignment,   -> { due_on_or_after(future_due_date).assigned.asc(:due_date).limit(1) }
    
  scope :for_section,       ->(s) { where(section: s) }
  scope :for_teacher,       -> (t) { where(teacher: t) }
  scope :for_course,        -> (c) { where(course: c) }
 
  validate do |sa|
    errors.add(:base, 'SectionAssignment must have assignment') unless sa.assignment
  end
  
  before_create do |sa|
    sa.block = sa.section.block
    sa.teacher = sa.section.teacher
    sa.course = sa.section.course
    sa.academic_year = sa.section.academic_year
  end
  
  # validate do |sa|
  #   errors.add(:base, 'Assignment must have name and content to be used') unless sa.assignment.name.size > 0 && sa.assignment.content.size > 0
  # end

  track_history track_create: true

	def to_s
		return "#{due_date}/#{assigned}"
	end
  
  def potential_major_topics
    self.course.major_topics
  end
  
	def self.upcoming
		na = self.next_assignment.first
		if na
			return self.due_after(na.due_date)
		else
			return self.future
		end
	end
  
end

