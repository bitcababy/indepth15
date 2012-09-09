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

	embeds_many :section_assignments, store_as: :sas
	index "section_assignment.assgt_id" => 1
	index "section_assignment.due_date" => -1

	has_and_belongs_to_many :occurrences, inverse_of: nil
	# accepts_nested_attributes_for :occurrences
	
	scope :for_year, ->(y){ where(academic_year: y)}
	scope :current, ->{ where(academic_year: Settings.academic_year)}
	scope :for_teacher, ->(t) { where(teacher: t) }
	scope :for_block, ->(b) { where(block: b) }
	scope :for_course, ->(c) { where(course: b) }
	
	def upcoming_assignments
		return self.section_assignments.upcoming.asc(:due_date)
	end
	
	def current_assignments
		return self.section_assignments.current.asc(:due_date).limit(1)
	end
	
	def future_assignments
		return self.section_assignments.future.asc(:due_date)
	end

	def past_assignments(n=nil)
		ret = self.section_assignments.past.desc(:due_date)
		n ? ret.limit(n) : ret
	end
	
	def add_assignment(name, asst, due_date, show=true)
		return self.section_assignments.create! name: name, due_date: due_date, assignment: asst
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
	
	def self.import_from_hash(hash)
		year = hash[:academic_year] = hash.delete(:year)
		return if year < Settings.start_year

		occurrences = hash.delete(:which_occurrences)
		hash[:semester] = (hash.delete(:semesters) == 2) ? Course::SECOND_SEMESTER : Course::FIRST_SEMESTER
		teacher_id = hash.delete(:teacher_id)
		hash[:room] = hash[:room].to_s
		
		course_number = hash.delete(:course_num)
		course = Course.find_by(number: course_number)
		hash[:course] = course
		
		[:course_num, :semesters].each {|k| hash.delete(k)}

		teacher = Teacher.find_by login: teacher_id
		hash[:teacher] = teacher
		section = course.sections.create!(hash)

		occurrences = (occurrences == 'all') ? (1..5).to_a : (occurrences.split(',').collect {|x| x.to_i})
		for occ in occurrences
			section.occurrences.find_or_create_by(block: section.block, number: occ)
		end
		return section
	end
	

end