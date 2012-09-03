class AssignmentsController < ApplicationController
 	# POST Assignments
  # POST assignments.json
  protect_from_forgery except: [:create, :update]

  def create
		teacher_id = params['assignment'].delete('teacher_id').strip
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
					logger.warn "****** html"
	 				redirect_to assignment_url(@assignment), notice: 'Assignment was successfully created.' 
				}
				format.js
        format.json {
					logger.warn "****** js or json"
	 				render json: @assignment, status: :created, location: @assignment
				}
      else
        format.html { render action: "new" }
 				format.js
       	format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

end
