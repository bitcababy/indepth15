class AssignmentsController < ApplicationController
 	# POST Assignments
  # POST assignments.json
	#   protect_from_forgery except: [:create, :update, :show]
	# before_filter :find_assignment, only: [:show, :update, :delete]
	# 
	# ## REST methods
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
	# # 	assgt_id = params['assgt_id'].to_i
	# # 	if Assignment.where(assgt_id: assgt_id).exists?
	# # 		@assignment = Assignment.find_by(assgt_id: assgt_id)
	# # 		logger.warn "@assignment is nil" unless @assignment
	# # 	else
	# # 		redirect_to create
	# # 	end
	# # end
	# 
	#   def create
	# 	# This is temporary, until the system is finished
	# 	aid = params['assignment']['assgt_id']
	# 
	# 	if aid && Assignment.where(assgt_id: aid.to_i).exists?
	# 		assignment = Assignment.find_by(assgt_id: aid.to_i)
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
	# 	assgt_id = params['assgt_id'].to_i
	# 	if Assignment.where(assgt_id: assgt_id).exists?
	# 		assignment = Assignment.find_by(assgt_id: assgt_id)
	# 		render json: assignment.to_json
	# 		return
	# 	else
	# 		head :unprocessable_entity
	# 	end
	# end
	# 
	# protected
	# def find_assignment
	# 	@assigment = Assignment.find(params['id'])
	# end

end
