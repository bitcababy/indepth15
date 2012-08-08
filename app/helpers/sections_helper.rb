# encoding: UTF-8

module SectionsHelper
	include Utils

	def assignments_header(section)
		return "#{section.teacher.formal_name}'s #{academic_year_string(Settings.academic_year)} Assignments for Block #{section.block}"
	end
	
	def occurrence_options
		(1..Settings.num_occurrences).collect { |i| [i.to_s, i.to_s] }
	end
end
