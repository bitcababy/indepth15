class SectionAssignment
	include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::History::Trackable
  include Mongoid::DataTable
  include Utils
  
	field :dd, as: :due_date, type: Date, default: -> { Utils.future_due_date }
	field :assigned, type: Boolean, default: false
  
  validates :due_date, presence: true
  
	index({due_date: -1, assigned: 1})
	
	belongs_to :section, counter_cache: true, autosave: true 
	belongs_to :assignment, counter_cache: true, autosave: true
  
  delegate :name, :content, :content=, to: :assignment
  delegate :block, :course, :teacher, :year to: :section

  scope :for_section,       ->(s) { where(section: s) }

  scope :due_after,         ->(date){ gt(due_date: date) }
  scope :due_on_or_after,   ->(date) { gte(due_date: date) }
  scope :due_on,            ->(date){ where(due_date: date) }
  scope :due_before,        ->(date) { lt(due_date: date) }
  scope :assigned,          -> { where(assigned: true) }
  scope :past,              -> { due_before(future_due_date).assigned }
  scope :future,            -> { due_on_or_after(future_due_date ).assigned }
  scope :next_assignment,   -> { due_on_or_after(future_due_date).assigned.asc(:due_date).limit(1) }
    
  data_table_options.merge!({
    fields: %w(year course teacher semester block name asst),
    dataset: ->(sa) {
      {
        0 => sa.section.year,
        1 => sa.section.course.full_name,
        2 => sa.section.teacher.full_name,
        3 => sa.section.duration,
        4 => sa.section.block,
        5 => sa.assignment.name,
        6 => sa.assignment.content
      }
    }
  })

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
  
  # def self.filter_by(year: nil, teacher: nil, course: nil, limit: nil)
  #   crit = limit ? SectionAssignment.limit(limit) : SectionAssignment.all
  #   crit = crit.for_teacher(teacher) if teacher
  #   crit = crit.for_course(course) if course
  #   crit = crit.for_year(year) if year
  #   return crit
  # end
  # 
  # def self.sort_by(crit, year: :desc)
  #   crit = crit.order_by(year: year)
  # end
      
end

