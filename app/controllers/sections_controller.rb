class SectionsController < ApplicationController
	before_filter :find_section

	def show
    respond_to do |format|
      format.html {render :layout => !request.xhr?}
    end
	end
	
	def assignments
    respond_to do |format|
      format.html {render :layout => !request.xhr?}
    end
	end
	
	def past_assignments
		respond_to do |format|
			format.html {render :layout => !request.xhr?}
			format.json { render json: @section.past_assignments }
    end
	end

	def current_assignment
		respond_to do |format|
      format.html {render :layout => !request.xhr?}
			format.json { render json: @section.current_assignments }
    end
	end

	def upcoming_assignments
		limit = params['limit'] || 2
		respond_to do |format|
      format.html {render :layout => !request.xhr?}
			format.json { render json: @section.upcoming_assignments }
    end
	end

	protected
	def find_section
		@section = Section.find(params['id'])
	end
	

end
