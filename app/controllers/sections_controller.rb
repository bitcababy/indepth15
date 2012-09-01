class SectionsController < ApplicationController
	before_filter :find_section

	def show
    respond_to do |format|
      format.html {render :layout => !request.xhr?}
 			format.js
			format.json { render json: @course}
   end
	end

	def assignments
    respond_to do |format|
      format.html {render :layout => !request.xhr?}
    end
	end

	protected
	def find_section
		@section = Section.find(params['id'])
	end

end
