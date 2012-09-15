class SectionsController < ApplicationController
	before_filter :find_section

	def show
    respond_to do |format|
      format.html {render :layout => !request.xhr?}
 			format.js
			format.json { render json: @section}
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
		@section = Section.find(params[:id])
	end

end
