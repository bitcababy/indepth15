class AssignmentsController < ApplicationController
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
    dd = Date.today + 1
    dd += 2 if dd.saturday?
    dd += 1 if dd.sunday?
    @sas = sections.collect {|s| SectionAssignment.new section: s, assignment: @assignment, due_date: dd}
    respond_to do |format|
      format.html
    end
  end
  
  def create
    
  end
  
	# 
  ## REST methods
  # def new
  #   course = Course.find params[:course_id]
  #   teacher = Teacher.find params[:teacher_id]
  #   sections = teacher.sections.for_course(course)
  #   @assignment = Assignment.new
  #   sas= []
  #   for section in sections do
  #     sas << SectionAssignment.new(section: section, assignment: @assignment, due_date: Date.tomorrow, use: true)
  #   end
  #   @assignment.section_assignments = sas
  #   respond_to do | format|
  #     format.html
  #   end
  # end
  # 
  
	# def show
	#     respond_to do |format|
	#       format.html { render :layout => !request.xhr? }
	# 		format.js
	# 		format.json { render json: @assignment}
	# 	end
	# end
	# 
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
	# 
	#   def create
	# 	# This is temporary, until the system is finished
	# 	aid = params['assignment']['oid']
	# 
	# 	if aid && Assignment.where(oid: aid.to_i).exists?
	# 		assignment = Assignment.find_by(oid: aid.to_i)
	# 		params['id'] = assignment.to_param
	# 		redirect_to update
	# 		return
	# 	end
	# 		
	# 	teacher_id = params.delete('teacher_id').strip
	# 	teacher = Teacher.find_by(login: teacher_id)
	# 	if teacher
	# 		@assignment = Assignment.new(params['assignment'])
	# 	else
	# 		@assignment = nil
	# 	end
	# 
	#     respond_to do |format|
	#       if @assignment.save
	# 			teacher.assignments << @assignment
	#         format.html {
	#  				redirect_to assignment_url(@assignment), notice: 'Assignment was successfully created.' 
	# 				return
	# 			}
	# 			format.js
	#         format.json {
	#  				render json: @assignment, status: :created, location: @assignment
	# 			}
	#       else
	#         format.html { render action: "new" }
	#  				format.js
	#        	format.json { render json: @assignment.errors, status: :unprocessable_entity }
	#       end
	#     end
	#   end
	# 
	# def get_one
	# 	oid = params['oid'].to_i
	# 	if Assignment.where(oid: oid).exists?
	# 		assignment = Assignment.find_by(oid: oid)
	# 		render json: assignment.to_json
	# 		return
	# 	else
	# 		head :unprocessable_entity
	# 	end
	# end
	# 
  protected
  def find_assignment
    @assigment = Assignment.find(params[:id])
  end

end
