# encoding: UTF-8

module SectionsAssignmentsHelper
  def year_options_for_search
    return options_for_select((Settings.start_year..Settings.academic_year).to_a.reverse)
  end
  
  def course_options_for_search
    return options_for_select(Course.asc(:number).collect {|c| [c.menu_label, c.to_param] })
  end
  
  def teacher_options_for_search
    return options_for_select(Teacher.asc(:login).collect {|t| [t.menu_label, t.to_param] })
  end
    
end
