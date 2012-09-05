class SectionAssignment
	include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'

	include Utils

  # include Mongoid::Timestamps

	field :dd, as: :due_date, type: Date
	field :na, as: :name, type: String, default: ""
	field :use, type: Boolean
	
	embedded_in :section
	belongs_to :assignment, index: true, inverse_of: nil
	belongs_to :course, index: true

	scope :after,	->(date) { gt(due_date: date) }
	scope :past, -> { lt(due_date: future_due_date) }
	scope :future, -> { gte(due_date: future_due_date) }
	scope :current, -> { gte(due_date: future_due_date).asc(:due_date).limit(1) }
	
	def self.upcoming
		current = self.current.first
		if current
			self.after(current.due_date)
		else
			self.future
		end
	end
	
	def self.get_sa(hash)
		assgt_id = hash.delete(:assgt_id)
		year = hash[:year]
		course_num = hash.delete(:course_num).to_i
		block = hash[:block]
		name = hash[:name]
		teacher_id = hash.delete(:teacher_id)
		course = Course.find_by(number: course_num)
		raise "Course #{course_num} not found" unless course
		teacher = Teacher.find_by(login: teacher_id)
		raise "Course #{teacher_id} not found" unless teacher
		section = Section.find_by(course: course, block: block, academic_year: year, teacher: teacher)
		raise "Section #{course}/#{block}/#{teacher_id} not found" unless teacher
		assignment = Assignment.find_by(assgt_id: assgt_id)
		hash[:course] = course
		return section,assignment
	end
	
	def self.import_from_hash(hash)
		section,assignment = self.get_sa(hash)
		
		crit = section.section_assignments.where(section: section, assignment: assignment, block: hash[:block])
		if crit.exists?
			sa = crit.first
			raise "no section_assignment" unless sa
			sa.due_date = hash[:due_date]
			sa.use = hash[:use_assgt]
			sa.save!
		else
			hash[:use] = (hash.delete(:use_assgt) == 'Y')
			hash[:assignment] = assignment
			section.section_assignments.create! hash
		end
	end


end

