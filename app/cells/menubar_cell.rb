class MenubarCell < Cell::Rails

  def display
    render
  end

  def display_home
    render
  end

  def display_courses
		@courses = Course.in_catalog
    render :display_courses
  end

  def display_teachers
		@teachers = Teacher.current.asc([:last_name, :first_name])
    render
  end

  def display_admin
    render
  end


end
