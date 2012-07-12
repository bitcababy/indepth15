# encoding: UTF-8

module ApplicationHelper

	def academic_year_string
		return "#{Settings.academic_year-1}–#{Settings.academic_year}"
	end
	
	def assignment_date_string(date)
		date.strftime("%a, %b %-d")
	end
	
	
end
