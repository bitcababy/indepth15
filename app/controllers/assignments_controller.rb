class AssignmentsController < ApplicationController
  include DueDate
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :check_for_cancel, only: [:create, :update]
  before_filter :find_assignment, only: [:update, :edit, :destroy]

  def new
    course = Course.find params[:course_id]
    teacher = Teacher.find params[:teacher_id]
    sections = course.sections.current.select {|s| s.teacher == teacher }
    name = teacher.last_asst_number(course)
    @assignment = Assignment.new name: name + 1

    @page_header = page_header course: course, teacher: teacher

    dd = next_school_day
    sections.each {|s| @assignment.section_assignments.new section: s, due_date: dd, block: s.block}
    respond_to do |format|
      format.html { render layout: !request.xhr?}
    end
  end

  def edit
    sa = @assignment.section_assignments.first
    course = sa.course
    teacher = sa.teacher
    @page_header = page_header course: course, teacher: teacher
      respond_to do |format|
    format.html { render layout: !request.xhr? }
    end
  end

  def create
    asst_params = params[:assignment]
    name = asst_params[:name]
    name = name.to_i if name =~ /^\d+$/

    asst = Assignment.create(name: name, content: asst_params[:content])
    if asst
      sa_params = asst_params[:section_assignments_attributes]
      sa_params.values.each do |attrs|
        section = Section.find attrs[:section_id]
        section.section_assignments.create assignment: asst, due_date: attrs[:due_date], assigned: attrs[:assigned] == "1"
      end
      flash[:info] = "Assignment created"
      load_stored_page
    else
      redirect_to :edit
    end
  end

  def update
    asst_params = params[:assignment]
    name = asst_params[:name]
    name = name.to_i if name =~ /\d+/
    if @assignment.update_attributes(name: name, content: asst_params[:content])
      sa_params = asst_params[:section_assignments_attributes]
      sa_params.values.each do |attrs|
        section = Section.find attrs[:section_id]
        sa = section.section_assignments.find_by(section: section, assignment: @assignment)
        sa.update_attributes due_date: attrs[:due_date], assigned: attrs[:assigned]
      end
      flash[:info] = "Assignment updated"
      load_stored_page
    else
      redirect_to :edit
    end
  end

  def destroy
    @assignment.destroy
    load_stored_page
  end

  protected
  def find_assignment
    @assignment = Assignment.find(params[:id])
  end

  def page_header(course: course, teacher: teacher)
    return "#{course.menu_label}, #{teacher.formal_name}'s sections"
  end

end
