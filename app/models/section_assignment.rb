class SectionAssignment
	include Mongoid::Document

	field :due_date, type: Date
	field :published, type: Boolean
	field :name, type: String
	
	belongs_to :section
	belongs_to :assignment
	
	scope :future, -> { gte(due_date: Utils.future_due_date) }
	scope :past, -> { lt(due_date: Utils.future_due_date) }
	# 
	# class << self
	# 	def convert_record(hash)
	# 		assgt_id = hash['assgt_id']
	# 		hash['published'] = hash['use_assgt'] == 'Y'
	# 		block = hash['block']
	# 		# puts hash
	# 
	# 		course = Course.find_by(number: hash['course_num'], academic_year: hash['schoolyear'])
	# 		raise "course is nil" unless course
	# 		teacher = Teacher.find_by(login: hash['teacher_id'])
	# 		raise "teacher is nil" unless teacher
	# 		# puts "Block: #{block}"
	# 		# puts "course.sections: #{course.sections}"
	# 		# puts course.sections.select {|s| s.block == block && s.teacher == teacher}
	# 		section = (course.sections.select {|s| s.block == block && s.teacher == teacher}).first
	# 		unless section
	# 			puts "can't find section for #{hash['schoolyear']}/#{teacher}/#{block}/#{assgt_id}"
	# 			return
	# 		end
	# 		# puts "Section: #{section}"
	# 		assignment = Assignment.find_by(orig_id: assgt_id)
	# 		assignment.tags << Tag.find_or_create_by(label: course.full_name)
	# 
	# 		%W(assgt_id schoolyear use_assgt block teacher_id).each {|k| hash.delete(k)}
	# 		
	# 		sa = section.section_assignments.new hash
	# 		sa.assignment = assignment
	# 		sa.save!
	# 		sa
	# 	end
	# end


end

