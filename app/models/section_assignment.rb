class SectionAssignment
	include Mongoid::Document
  # include Mongoid::Timestamps

	field :dd, as: :due_date, type: Date
	field :na, as: :name, type: String, default: ""
	
	belongs_to :section
	belongs_to :assignment
	belongs_to :course
	
	accepts_nested_attributes_for :section, :assignment
	
	scope :future, -> { gte(due_date: Utils.future_due_date) }
	scope :past, -> { lt(due_date: Utils.future_due_date) }
	
	def self.import_from_hash(hash)
		return unless hash[:use_assgt] == 'Y'
		assgt_id = hash[:assgt_id]
		block = hash[:block]
		year = hash[:schoolyear]

		course = Course.find_by(number: hash[:course_num])
		raise "course is nil" unless course
		teacher = Teacher.find_by(login: hash[:teacher_id])
		raise "teacher is nil" unless teacher
		section = Section.find_by(course: course, block: block, academic_year: year, teacher: teacher)
		unless section
			puts "can't find section for #{year}/#{teacher}/#{block}/#{assgt_id}"
			return
		end

		assignment = Assignment.find_by(assgt_id: assgt_id)

		[:assgt_id,:schoolyear,:use_assgt,:block,:teacher_id].each {|k| hash.delete(k)}
		
		[:assgt_id,:schoolyear,:use_assgt,:block,:teacher_id, :course_num].each {|k| hash.delete(k)}
		hash[:name] = assignment.name
		sa = section.section_assignments.create! hash

		sa.assignment = assignment
		sa.save!
		return sa
	end


end

