class SectionAssignment
	include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'

	include Utils

  # include Mongoid::Timestamps

	field :dd, as: :due_date, type: Date
	field :na, as: :name, type: String, default: ""
	
	embedded_in :section
	belongs_to :assignment, index: true, inverse_of: nil
	belongs_to :course, index: true
	
	scope :after,	->(date) { gt(due_date: date) }
	scope :past, -> { lt(due_date: future_due_date) }
	scope :future, -> { gte(due_date: future_due_date) }
	scope :current, -> { gte(due_date: future_due_date).limit(1) }
	
	def self.upcoming
		current = self.current.first
		if current then
			self.after(current.due_date)
		else
			self.future
		end
	end
	
	def self.import_from_hash(hash)
		return unless hash[:use_assgt] == 'Y'
		assgt_id = hash[:assgt_id]
		block = hash[:block]
		year = hash[:schoolyear]

		course = Course.find_by(number: hash[:course_num])
		raise "course is nil for #{hash[:course_num]}" unless course
		teacher = Teacher.find_by(login: hash[:teacher_id])
		raise "teacher is nil for #{hash[:teacher_id]}" unless teacher
		section = Section.find_by(course: course, block: block, academic_year: year, teacher: teacher)
		unless section
			puts "can't find section for #{year}/#{teacher}/#{block}/#{assgt_id}"
			return
		end

		assignment = Assignment.find_by(assgt_id: assgt_id)

		[:assgt_id,:schoolyear,:use_assgt,:block,:teacher_id, :course_num].each {|k| hash.delete(k)}
		hash[:name] = assignment.name
		sa = section.section_assignments.create! hash

		sa.assignment = assignment
		sa.course = course
		sa.save!
		return sa
	end


end

