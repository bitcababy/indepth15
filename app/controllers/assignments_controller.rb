class AssignmentsController < ApplicationController
  include Utils
  protect_from_forgery except: [:create, :update, :show]
  before_filter :authenticate_user!
  before_filter :find_assignment, only: [:update, :delete, :edit]
  
  def new
    course = Course.find params[:course_id]
    teacher = Teacher.find params[:teacher_id]
    sections = course.sections.current.select {|s| s.teacher == teacher }
    @assignment = Assignment.new
    
    # @major_topics =  MajorTopic.names_for_topics(course.major_topics).sort
    dd = next_school_day
    sections.each {|s| @assignment.section_assignments.new section: s, due_date: dd, block: s.block}
    respond_to do |format|
      format.html { render layout: !request.xhr?}
    end
  end

  def edit
		respond_to do |format|
			format.html { render layout: !request.xhr? }
    end
  end

  def create
    asst_params = params[:assignment]
    name = asst_params[:name]
    name = name.to_i if name =~ /\d+/

    asst = Assignment.create(name: name, content: asst_params[:content])
    if asst
      sa_params = asst_params[:section_assignments_attributes]
      sa_params.values.each do |attrs|
        section = Section.find attrs[:section_id]
        section.section_assignments.create assignment: asst, due_date: attrs[:due_date], assigned: attrs[:assigned]
      end
      flash[:info] = "Assignment created"
      redirect_to stored_page || home_path
    else
      redirect_to :edit
    end
  end
  
  def update
    asst_params = params[:assignment]
    name = asst_params[:name]
    if @assignment.update_attributes(name: name, content: asst_params[:content])
      sa_params = asst_params[:section_assignments_attributes]
      sa_params.values.each do |attrs|
        section = Section.find attrs[:section_id]
        sa = section.section_assignments.find_by(section: section, assignment: @assignment)
        sa.update_attributes due_date: attrs[:due_date], assigned: attrs[:assigned]
      end
      flash[:info] = "Assignment updated"
      redirect_to stored_page || home_path
    else
      redirect_to :edit
    end
  end
  
  protected
  def find_assignment
    @assignment = Assignment.find(params[:id])
  end

end
