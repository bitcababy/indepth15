class MenubarCell < Cell::Rails
  include Devise::Controllers::Helpers
  helper_method :current_user, :user_signed_in?

  def display
    render
  end

  def display_teacher_menu
    render
  end

  def display_home
		if true
			@sign_in_out_text = "Sign in"
			@url = sign_in_url
		else
			if user_signed_in? then
				@sign_in_out_text = "Sign out"
				@url = sign_out_url
			else
				@sign_in_out_text = "Sign in"
				@url = sign_in_url
			end
		end
    render
  end

  def display_courses
		@courses = Course.in_catalog
    render :display_courses
  end

  def display_faculty
		@teachers = Teacher.current.asc([:last_name, :first_name])
    render
  end

  def display_admin
 		render
  end


end
