class SectionsController < ApplicationController
	before_filter :find_section

	def show
		if @section
	    respond_to do |format|
	      format.html {render :layout => !request.xhr?}
	 			format.js
				format.json { render json: @section}
		   end
		else
			redirect_to root_path, notice: 'Invalid section'
		end
	end

	def assignments
		if @section 
	    respond_to do |format|
	      format.html {render :layout => !request.xhr?}
	    end
		else
			# This probably isn't right
			redirect_to root_path, notice: 'Invalid section'
		end
	end

	protected
	def find_section
		begin
			@section = Section.find(params['id'])
		rescue Mongoid::Errors::DocumentNotFound
			logger.error "Invalid course"
			@section = nil
		end
	end

end
