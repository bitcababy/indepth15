# encoding: UTF-8

module SectionsHelper
	def page_header(section)
		return "#{section.teacher.formal_name}'s #{academic_year_string(Settings.academic_year)} Assignments for Block #{section.block}"
	end
	
	def page_title(section)
		"#{section.course.full_name} | #{section.teacher.formal_name}, Block #{section.block}"
	end
	
	def occurrence_options
		return (1..Settings.max_occurrences).collect { |i| [i.to_s, i.to_s] }
	end
end
