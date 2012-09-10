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
			redirect_to '/'
		end
	end

	protected
	def find_section
		begin
			@section = Section.find(params['id'])
		rescue
			@section = nil
		end
	end

end
