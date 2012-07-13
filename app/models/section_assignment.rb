class SectionAssignment
	include Mongoid::Document

	field :due_date, type: Date
	field :published, type: Boolean
	field :name, type: String, default: ""
	
	belongs_to :section
	belongs_to :assignment
	
	scope :future, -> { gte(due_date: Utils.future_due_date) }
	scope :past, -> { lt(due_date: Utils.future_due_date) }
	
	def self.import_from_hash(hash)
		assgt_id = hash[:assgt_id]
		hash[:published] = hash[:use_assgt] == 'Y'
		block = hash[:block]

		course = Course.find_by(number: hash[:course_num], academic_year: hash[:schoolyear])
		raise "course is nil" unless course
		teacher = Teacher.find_by(login: hash[:teacher_id])
		raise "teacher is nil" unless teacher
		section = (course.sections.select {|s| s.block == block && s.teacher == teacher}).first
		unless section
			puts "can't find section for #{hash['schoolyear']}/#{teacher}/#{block}/#{assgt_id}"
			return
		end

		assignment = Assignment.find_by(assgt_id: assgt_id)
		tc = Tag::Course.find_or_create_by(number: course.number)
		tc.documents << assignment

		[:assgt_id,:schoolyear,:use_assgt,:block,:teacher_id].each {|k| hash.delete(k)}
		
		hash[:name] = assignment.name
		sa = section.section_assignments.create! hash
		sa.assignment = assignment
		sa.save!
		return sa
	end


end

