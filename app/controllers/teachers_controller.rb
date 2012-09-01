class TeachersController < ApplicationController
	before_filter :find_teacher, only: [:show]

	def show
    format.html {render :layout => !request.xhr?}
		format.js
		format.json { render json: @teacher}
	end

	protected
	def find_section
		@teacher = Teacher.find(params['id'])
	end

end
