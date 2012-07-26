# encoding: UTF-8

module SectionsHelper
	def assignments_header(section)
		return "#{section.teacher.formal_name}'s #{academic_year_string(Settings.academic_year)} Assignments for Block #{section.block}"
	end
end
