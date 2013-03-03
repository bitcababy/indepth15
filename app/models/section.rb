# encoding: UTF-8

class Section
	include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable

	field :bl, as: :block, type: String
	validates :block, presence: true, inclusion: { in: Settings.blocks }

	field :rm, as: :room, type: String, default: ""

	field :se, as: :semesters, type: Symbol
	validates :semesters, presence: true, inclusion: { in: Course::DURATIONS }

	field :ay, as: :academic_year, type: Integer, default: Settings.academic_year
	validates :academic_year, presence: true, numericality: true
  
  field :days, type: Array, default: (1..5).to_a
  
  field :_id, type: String, default: ->{ "#{academic_year}/#{course.to_param}/#{teacher.to_param}/#{block}"}

	index({ academic_year: -1, semesters: 1, block: 1 }, { name: 'ysb' } )
	index({academic_year: -1}, {name: 'ay'})
  
	has_many :section_assignments
	belongs_to :course, index: true
	belongs_to :teacher, index: true

  scope :current, ->{ where(academic_year: Settings.academic_year) }

  scope :for_year, ->(y){ where(academic_year: y)}
  scope :for_teacher, ->(t){ where(teacher: t) }
  scope :for_block, ->(b){ where(block: b) }
  scope :for_course, ->(c){ where(course: c) }
  scope :for_first_semester, ->{  any_in(semesters: [Course::FULL_YEAR, Course::FULL_YEAR_HALF_TIME, Course::FIRST_SEMESTER]) }
  scope :for_second_semester, ->{  any_in(semesters: [Course::FULL_YEAR, Course::FULL_YEAR_HALF_TIME, Course::SECOND_SEMESTER]) }
  scope :for_semester, ->(s){ (s == Course::FIRST_SEMESTER) ? for_first_semester : for_second_semester }
  
  # delegate :major_topics, to: :course
  delegate :department, to: :course
	
  track_history track_create: true

	def to_s
		return "#{self.academic_year}/#{self.course.number}/#{self.teacher.login}/#{self.block}"
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
	
	def add_assignment(name, asst, due_date, assigned=true)
		return self.section_assignments.create! name: name, due_date: due_date, assignment: asst, assigned: assigned
	end
	
	def page_header
		"#{course.full_name}, Block #{self.block}"
	end
		
end
