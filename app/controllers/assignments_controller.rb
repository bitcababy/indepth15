class AssignmentsController < ApplicationController
  include Utils
  protect_from_forgery except: [:create, :update, :show]
  before_filter :authenticate_user!
  before_filter :find_assignment, only: [:show, :update, :delete]
  
  def new
    course = Course.find params[:course_id]
    teacher = Teacher.find params[:teacher_id]
    sections = course.sections.current.select {|s| s.teacher == teacher }
    @assignment = Assignment.new
    @assignment.teacher = teacher
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
    teacher = Teacher.find asst_params[:teacher_id]
    sa_params = asst_params[:section_assignments_attributes]

    begin
      asst = teacher.assignments.create name: asst_params[:name], content: asst_params[:content]
      redirect_to :edit unless asst

      sa_params.values.each do |attrs|
        section = Section.find attrs[:section]
        section.section_assignments.create assignment: asst, due_date: attrs[:due_date], assigned: attrs[:assigned]
      end
    rescue
      logger.warn 'AssignmentController#create failed!'
    end #begin

   logger.warn "stored_page is #{stored_page}"
   redirect_to stored_page || home_path
  end
  
  
  protected
  def find_assignment
    @assigment = Assignment.find(params[:id])
  end

end
