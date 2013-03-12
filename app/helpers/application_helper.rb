# encoding: UTF-8

module ApplicationHelper
	include Utils
	# include UsersHelper

	def academic_year_string(year)
		return "#{year-1}–#{year}"
	end

	def is_are_number_mangler(n, word)
		res = (n > 1 || n == 0) ? 'are ' : 'is '
		return res + pluralize(n, word).gsub(/^0/, 'no')
	end
	
	def duration_string(duration)
		return case duration
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
	
	def section_label_for_menu(section)
		if section.teacher then
			return section.label_for_course
		else
			return section.to_s
		end
	end

  def custom_form_for(object, *args, &block)
		options = args.extract_options!
		simple_form_for(object, *(args << options.merge(:builder => CustomFormBuilder)), &block)
  end

	def hidden_div_if(condition, attributes = {}, &block)
		if condition
			attributes['style'] = "display: none"
		end
		content_tag('div', attributes, &block) if block
	end

	def course_home_with_assignments(section)
		return home_with_assignments_path(section.course.to_param, section.teacher.to_param, section.block)
	end
  
    ## Note: Unclear why I need any of these
  	##
  	## Devise methods
  	##
    def current_user
      return @current_user ||= warden.authenticate(:scope => :user)
    end
  
    def current_user_name
      return user_signed_in? ? current_user.full_name : "Guest"
    end
  
    def user_signed_in?
      return !!current_user
    end
    # 
    def user_session
      return current_user && warden.session(:user)
    end

    def editable?
      return user_signed_in?
    end

end
