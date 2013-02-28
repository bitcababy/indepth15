class AssignmentsController < ApplicationController
  include Utils
 	# POST Assignments
  # POST assignments.json
  protect_from_forgery except: [:create, :update, :show]
  before_filter :find_assignment, only: [:show, :update, :delete]
  before_filter :authenticate_user!
  
  def edit
		respond_to do |format|
			format.html { render layout: !request.xhr? }
    end
  end
  
  def new
    course = Course.find params[:course_id]
    teacher = Teacher.find params[:teacher_id]
    sections = course.sections.current.select {|s| s.teacher == teacher }
    @assignment = Assignment.new
    @assignment.teacher = teacher
    # @major_topics =  MajorTopic.names_for_topics(course.major_topics).sort
    dd = next_school_day
    sections.each {|s| @assignment.section_assignments.new section: s, due_date: dd}
    respond_to do |format|
      format.html { render layout: !request.xhr?}
    end
  end

  def create
    asst_params = params[:assignment]
    # mjs = asst_params[:major_topics]
    # mjs = mjs ?( mjs.reject {|mj| mj.empty? }) : ""
    
    teacher = Teacher.find asst_params[:teacher_id]
    sa_params = asst_params[:section_assignments_attributes]
    begin
      asst = teacher.assignments.create name: asst_params[:name], content: asst_params[:content]
      # asst.add_major_topics(mjs)

      sa_params.values.each do |attrs|
        section = Section.find attrs[:section]
        section.section_assignments.create assignment: asst, due_date: attrs[:due_date], published: attrs[:published]
       end
    end
    redirect_to stored_page || home_path
  end
  
	# 
  ## REST methods
  
	# # PUT assignments/1
	#   # PUT assignments/1.json
	#   def update
	#     respond_to do |format|
	#       if @assignment.update_attributes(params[:assignment])
	#         format.html { redirect_to assignment_path(@assignment), notice: 'assignment was successfully updated.' }
	#         format.json { head :no_content }
	#       else
	#         format.html { render action: "edit" }
	#         format.json { render json: @assignment.errors, status: :unprocessable_entity }
	#       end
	#     end
	# 	return
	#   end
	# 
	# # def create_or_update
	# # 	oid = params['oid'].to_i
	# # 	if Assignment.where(oid: oid).exists?
	# # 		@assignment = Assignment.find_by(oid: oid)
	# # 		logger.warn "@assignment is nil" unless @assignment
	# # 	else
	# # 		redirect_to create
	# # 	end
	# # end
	# def show
	#     respond_to do |format|
	#       format.html { render :layout => !request.xhr? }
	# 		format.js
	# 		format.json { render json: @assignment}
	# 	end
	# end
	# 
  
  protected
  def find_assignment
    @assigment = Assignment.find(params[:id])
  end

end
