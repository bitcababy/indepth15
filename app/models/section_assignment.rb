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
	
	def self.handle_incoming(hashes)
		hashes = [hashes] unless hashes.kind_of? Array
		for hash in hashes do
			assgt_id = hash['assgt_id']
			year = hash['year']
			course_num = hash['course_num'].to_i
			block = hash['block']
			name = hash['name']
			due_date = Date.parse(hash['due_date'])
			teacher_id = hash['teacher_id']
			course = Course.find_by(number: course_num)
			raise ArgumentError, "course is nil for #{course_num}" unless course
			teacher = Teacher.find_by(login: teacher_id)
			raise ArgumentError, "teacher is nil for #{hash['teacher_id']}" unless teacher
			section = Section.find_by(course: course, block: block, academic_year: year, teacher: teacher)
			raise ArgumentError, "can't find section for #{year}/#{teacher}/#{block}" unless section
			assignment = Assignment.find_by(assgt_id: assgt_id)
			raise ArgumentError,  "can't find assignment for #{year}/#{teacher}/#{block}/#{assgt_id}" unless assignment

			if section.section_assignments.where(assignment: assignment, name: name).exists?
				sa = section.section_assignments.find_by(assignment: assignment, name: name)
				sa.due_date = due_date if sa.due_date != due_date
				sa.name = hash['name'] unless sa.name = hash['name']
				use = (hash['use_assgt'] == 'Y')
				sa.use = use unless sa.use == use
				sa.save!
			else
				sa = section.section_assignments.create! due_date: due_date, name: name, assignment: assignment, use: use
				return sa
			end
		end
	end
	
	
	def self.import_from_hash(hash)
		assgt_id = hash[:assgt_id]
		block = hash[:block]
		year = hash[:year]

		course = Course.find_by(number: hash[:course_num])
		raise ArgumentError, "course is nil for #{hash[:course_num]}" unless course
		teacher = Teacher.find_by(login: hash[:teacher_id])
		raise ArgumentError, "teacher is nil for #{hash[:teacher_id]}" unless teacher
		section = Section.find_by(course: course, block: block, academic_year: year, teacher: teacher)
		raise ArgumentError, "can't find section for #{year}/#{teacher}/#{block}" unless section
		assignment = Assignment.find_by(assgt_id: assgt_id)
		raise ArgumentError,  "can't find assignment for #{year}/#{teacher}/#{block}/#{assgt_id}" unless assignment

		[:teacher_id, :assgt_id, :dept_id, :course_num, :ada, :aa].each {|k| hash.delete(k)}
		hash[:course] = course
		hash[:assignment] = assignment
		sa = section.section_assignments.create! hash

		sa.assignment = assignment
		sa.course = course
		sa.save!
		return sa
	end


end

