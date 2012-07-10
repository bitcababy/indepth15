class Import::SectionAssignment  < Import
	cattr_reader :mapping
	
	@@mapping = {
		"id" 							=> :orig_id,
		"assgt_id" 				=> :assgt_id,
		"teacher_id" 			=> :teacher_id,
		"block" 					=> :block,
		"use_assgt" 			=> :use_assgt,
		"schoolyear" 			=> :schoolyear,
		"date_due" 				=> :due_date,
		"course_num" 			=> :course_num,
		"deleted" 				=> :deleted,
	}

	def self.gather_all_for_export
		self.where(:schoolyear.gte => 2011).desc(:schoolyear).all
	end
	
end
