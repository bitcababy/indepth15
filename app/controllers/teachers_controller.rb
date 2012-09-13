class TeachersController < ApplicationController
	before_filter :find_teacher, only: [:show]

	def show
		if @teacher
	    respond_to do |format|
	 	   format.html {render :layout => !request.xhr?}
				format.js
				format.json { render json: @teacher}
			end
		else
			redirect_to root_url, notice: 'Invalid teacher'
		end
	end

	protected
	def find_teacher
		begin
			@teacher = Teacher.find(params[:id])
		rescue Mongoid::Errors::DocumentNotFound
			@teacher = nil
		end
	end

end
