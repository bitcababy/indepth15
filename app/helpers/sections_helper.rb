# encoding: UTF-8

module SectionsHelper
	def assignments_header(section)
		"#{section.teacher.formal_name}'s #{academic_year_string} Assignments for Block #{section.block}"
	end
end
