# encoding: UTF-8

class Section
	include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'

	SEMESTERS = [Course::FIRST_SEMESTER, Course::SECOND_SEMESTER]

	field :de, as: :dept, type: Integer

	field :bl, as: :block, type: String
	validates :block, presence: true, inclusion: {in: Settings.blocks}

	field :rm, as: :room, type: String

	field :se, as: :semester, type: Symbol
	validates :semester, presence: true, inclusion: {in: SEMESTERS}

	field :ay, as: :academic_year, type: Integer, default: Settings.academic_year
	validates :academic_year, presence: true, numericality: true
	
	index({ academic_year: -1, semester: 1, block: 1 }, { name: 'ysb' } )
	index({academic_year: -1}, {name: 'ay'})
	belongs_to :course, index: true
	belongs_to :teacher, index: true

	has_many :section_assignments

	has_and_belongs_to_many :occurrences, inverse_of: nil
	# accepts_nested_attributes_for :occurrences
	
	scope :for_year, ->(y){ where(academic_year: y)}
	scope :current, ->{ where(academic_year: Settings.academic_year)}
	scope :for_teacher, ->(t) { where(teacher: t) }
	scope :for_block, ->(b) { where(block: b) }
	scope :for_course, ->(c) { where(course: c) }
	
	def to_s
		"#{self.academic_year}/#{self.course.number}/#{self.teacher}/#{self.block}"
	end
	
	def label_for_teacher
		return "#{self.course.short_name || self.course.full_name}, Block #{self.block}"
	end
		
	def label_for_course
		return "#{self.teacher.formal_name}, Block #{self.block}"
	end

	def upcoming_assignments
		return self.section_assignments.upcoming.asc(:due_date).published
	end
	
	def current_assignments
    if na = self.section_assignments.next_assignment.first
      return self.section_assignments.due_on(na.due_date).all.published
    else
      return []
    end
	end
	
	def future_assignments
		return self.section_assignments.future.asc(:due_date).published
	end

	def past_assignments(n=nil)
		ret = self.section_assignments.past.desc(:due_date).published
		n ? ret.limit(n) : ret
	end
	
	def add_assignment(name, asst, due_date, use=true)
		return self.section_assignments.create! name: name, due_date: due_date, assignment: asst, use: use
	end
	
	def page_header
		"#{course.full_name}, Block #{self.block}"
	end
		
	# def to_s
	# 	course = self.course
	# 	return "#{course.full_name}/#{self.academic_year}/#{self.teacher.login}/#{self.block}"
	# end
		
	def days_for_section
		return (self.occurrences.map &:day).sort

end