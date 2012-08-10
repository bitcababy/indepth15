# encoding: UTF-8

module ApplicationHelper
	include Utils
	include UserSessionHelper

	def academic_year_string(year)
		return "#{year-1}—#{year}"
	end

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
	
	def duration_string(duration)
		case duration
		when :full_year
			'Full Year'
		when :first_semester
			'First Semester'
		when :second_semester
			'Second Semester'
		when :halftime
			'Full Year, half time'
		end
	end
	
	def assignment_date_string(date)
		return date.strftime("%a, %b %-d")
	end
	
	def render_home_menu
		render partial: 'menus/home'
	end
	
	def render_courses_menu
		@courses = Course.in_catalog
		render partial: 'menus/courses' if @courses
	end
	
	def render_sections_of_course(course)
		sections = course.current_sections
		render partial: 'menus/section', collection: sections if sections
	end
	
	def render_teachers
		teachers = Teacher.current
		render partial: 'menus/teacher', collection: teachers if teachers
	end

	def render_faculty_menu
		render partial: 'menus/faculty'
	end
	
	def render_manage_menu
		render partial: 'menus/manage' if user_signed_in?
	end
	
	def render_menubar
		render partial: 'menus/menubar'
	end
	
	def section_label_for_menu(section)
		if section.teacher then
			section.teacher.formal_name + ", Block " + section.block
		else
			section.to_s
		end
	end

end
