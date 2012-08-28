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
	scope :current, -> { gte(due_date: future_due_date).limit(1) }
	
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
	
	def self.handle_incoming(hash)
		hash = Hash[hash]
		section,assignment = self.get_sa(hash)

		name = hash[:name]
		hash[:use] = (hash.delete(:use_assgt) == 'Y')
		[:ada, :aa].each {|k| hash.delete(k)}

		puts section.section_assignments.first

		# puts section.section_assignments.where(assignment: assignment, name: name).exists?
		if section.section_assignments.where(assignment: assignment, name: name).exists?
			puts hash
			sa = section.section_assignments.find_by(assignment: assignment, name: name)
			sa.update_attributes(hash)
			# sa.due_date = due_date if sa.due_date != due_date
			# sa.name = name unless sa.name = name
			# sa.use = use unless sa.use == use
			sa.save!
		else
			puts section.section_assignments.count
			[:ada, :aa].each {|k| hash.delete(k)}
			section.section_assignments.create! hash
			puts section.section_assignments.count
		end
	end
	
	def self.import_from_hash(hash)
		section,assignment = self.get_sa(hash)

		hash[:use] = (hash.delete(:use_assgt) == 'Y')

		[:ada, :aa].each {|k| hash.delete(k)}
		hash[:assignment] = assignment
		section.section_assignments.create! hash
	end


end

