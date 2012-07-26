# encoding: UTF-8

class Section
	include Mongoid::Document
  include Mongoid::Timestamps

	field :dept, type: Integer
	field :block, type: String
	field :room, type: String
	field :next_asst_num, type: Integer
	field :semester, type: Symbol
	field :occurrences, type: Array
	field :style_id, type: Integer
	field :academic_year, type: Integer, default: Settings.academic_year
	
	belongs_to :course
	belongs_to :teacher

	has_many :section_assignments

	cattr_reader :blocks, :semesters, :occurrences
	
	scope :for_year, lambda {|y| where(academic_year: y)}
	
	@@blocks = ('A'..Settings.last_block).to_a
	@@occurrences = (1..Settings.max_occurrences).to_a
	@@semesters = [Course::FIRST_SEMESTER, Course::SECOND_SEMESTER]

	def to_s
		"Section, block #{self.block}"
	end
	
	def add_assignment(asst, due_date, show=true)
		self.section_assignments.create! due_date: due_date, assignment: asst
	end
	
	def future_assignments
		self.section_assignments.future.asc(:date_due).map &:assignment
	end

	def past_assignments
		self.section_assignments.past.desc(:date_due).map &:assignment
	end
	
	def to_s
		course = self.course
		"#{course.full_name}#{course.academic_year}/#{self.teacher.login}/#{self.block}"
	end
	
	def menu_label
		if self.teacher then
			self.teacher.full_name + ", " + self.block
		else
			self.to_s
		end
	end
	
	def days_for_section
		(self.occurrences.collect {|occ| Occurrence.find_by(number: occ, block: self.block).day_number}).sort
	end
	
	class << self
		def import_from_hash(hash)
			year = hash[:academic_year] = hash[:year]
			return if year < Settings.start_year
	
			occurrences = hash[:which_occurrences]
			semesters = hash[:semesters]
			teacher_id = hash[:teacher_id]
			hash[:room] = hash[:room].to_s
			teacher = Teacher.find_by login: teacher_id
			%W(which_occurrences semester sched_color year dept_id number).each {|k| hash.delete(k)}
	
			hash[:occurrences] = (occurrences == :all) ? (1..5).to_a : (occurrences.split(',').collect {|x| x.to_i})
			
			hash[:semester] = [1,3,12].contains?(semesters) ? :first : :second
			course_number = hash[:course_num]

			course = Course.find_by(number: course_number)
			
			section = course.sections.create!(hash)
			section.teacher = teacher
			section.save!
			return section
		end
	
	end

end