class TeachersController < ApplicationController
	before_filter :find_teacher, only: [:show]

	def show
    respond_to do |format|
 	   	format.html {render :layout => !request.xhr?}
			format.js
			format.json { render json: @teacher}
		end
	end

	protected
	def find_teacher
		@teacher = Teacher.find(params[:id])
	end

end
