# encoding: UTF-8

module SectionsHelper
	def assignments_header(section)
		return "#{section.teacher.formal_name}'s #{academic_year_string(Settings.academic_year)} Assignments for Block #{section.block}"
	end
	
	def occurrence_options(section=nil)
		(1..Settings.max_occurrences).to_a.collect {|i| [true, i.to_s]}
	end
end
