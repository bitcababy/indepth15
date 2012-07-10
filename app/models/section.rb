# encoding: UTF-8

class Section
	include Mongoid::Document
  include Mongoid::Timestamps

	field :dept, type: Integer
	field :number, type: Integer
	field :block, type: String
	field :days, type: Array
	field :room, type: String
	field :next_asst_num, type: Integer
	field :semester, type: Symbol
	field :occurrences, type: Array
	field :style_id, type: Integer
	
	belongs_to :course
	belongs_to :teacher

	has_many :section_assignments

	validates_uniqueness_of :number, scope: :course, allow_nil: true
		
	def to_s
		"Section #{self.number}, block: #{self.block}"
	end
	
	def add_assignment(due_date, asst, show=true)
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
		
	class << self
		def convert_record(hash)
			year = hash['year']
			return if year < Settings.start_year

			occurrences = hash['which_occurrences']
			semesters = hash['semesters']
			teacher_id = hash['teacher_id']
			hash['room'] = hash['room'].to_s
			teacher = Teacher.find_by login: teacher_id
			%W(which_occurrences semester sched_color year dept_id).each {|k| hash.delete(k)}

			hash['occurrences'] = (occurrences == 'all') ? (1..5).to_a : (occurrences.split(',').collect {|x| x.to_i})
			hash['semester'] = [1,3,12].contains?(semesters) ? :first : :second
			course = Course.find_by(number: hash['course_num'], academic_year: year)
			raise "problem with section #{hash['orig_id']}" if course.sections.collect{|s| s.block}.contains? hash['block']
			
			section = course.sections.create!(hash)
			section.teacher = teacher
			section.save!
			return section
		end

	end

end