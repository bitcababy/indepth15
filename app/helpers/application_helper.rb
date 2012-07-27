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
	
	def render_home_menu
		render partial: 'menus/home'
	end
	
	def render_courses_menu
		@courses = Course.in_catalog
		render partial: 'menus/courses'
	end
	
	def render_sections_of_course(course)
		sections = course.sections.current
		render partial: 'menus/section', collection: sections
	end
	
	def render_teachers
		teachers = Teacher.current
		render partial: 'menus/teacher', collection: teachers
	end

	def render_faculty_menu
		render partial: 'menus/faculty'
	end
	
	def render_manage_menu
		# render partial: 'menus/manage'
	end
	
	def render_menubar
		render 'menus/menubar'
	end
		
		
end
