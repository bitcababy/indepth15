class AssignmentsController < ApplicationController
 	# POST Assignments
  # POST assignments.json
  protect_from_forgery except: [:create, :update]
	before_filter :find_assignment, only: [:show, :update, :delete]

	def show
		@assigment = Assignment.find(params['id'])
    respond_to do |format|
      format.html { render :layout => !request.xhr? }
		end
	end
	
	# PUT assignments/1
  # PUT assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to assignment_path(@assignment), notice: 'assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
		return
  end


  def create
		teacher_id = params['assignment'].delete('teacher_id').strip
		# This is temporary, until the system is finished
		if (aid = params['assgt_id']) && Assignment.where(assgt_id: aid.to_i).exists?
			assignment = Assignment.find_by(assgt_id: assgt_id)
			params['id'] = assignment.to_param
			redirect_to update
			return
		end
			
		teacher_id = params.delete('teacher_id').strip
		teacher = Teacher.find_by(login: teacher_id)
		if teacher
			@assignment = Assignment.new(params['assignment'])
		else
			@assignment = nil
		end

    respond_to do |format|
      if @assignment.save
				teacher.assignments << @assignment
        format.html {
	 				redirect_to assignment_url(@assignment), notice: 'Assignment was successfully created.' 
					return
				}
				format.js
        format.json {
	 				render json: @assignment, status: :created, location: @assignment
				}
      else
        format.html { render action: "new" }
 				format.js
       	format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

	protected
	def find_assignment
		@assigment = Assignment.find(params['id'])
	end

end
