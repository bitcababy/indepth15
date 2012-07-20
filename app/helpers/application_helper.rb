# encoding: UTF-8

module ApplicationHelper

	def is_are_number_mangler(n, word)
		case
			when n > 1
				res = "are "
			when n == 1 then
				res = "is "
			when n == 0 then
				res = "are "
		end
		return res + pluralize(n, word).gsub(/^0/, 'no')
	end

	def academic_year_string(year)
		return "#{year-1}—#{year}"
	end
	
	def assignment_date_string(date)
		return date.strftime("%a, %b %-d")
	end

	def link_for_menu_item(item)
 		case
		when item.link
			item.link
		when item.action && item.controller
			url_for(controller: item.controller, action: item.action)
		when item.object
			url_for(item.object)
		else
			raise "Not written yet"
		end
	end
		
end
