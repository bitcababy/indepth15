class SectionsController < ApplicationController
	before_filter :find_section

	def show
    respond_to do |format|
      format.html {render :layout => !request.xhr?}
    end
	end
	
	def assignments
		@past = self.past_assignments
		@current = self.current_assignment
		@upcoming = self.upcoming_assignments
    respond_to do |format|
      format.html {render :layout => !request.xhr?}
    end
	end
	
	def past_assignments
		@assignments = self.past_assignments
		respond_to do |format|
			format.html {render :layout => !request.xhr?}
			format.json { render json: @section.past_assignments }
    end
	end

	def current_assignment
		@assignments = self.current_assignment
		respond_to do |format|
      format.html {render :layout => !request.xhr?}
			format.json { render json: @section.current_assignments }
    end
	end

	def upcoming_assignments
		@assignments = self.upcoming_assignments
		respond_to do |format|
      format.html {render :layout => !request.xhr?}
			format.json { render json: @section.upcoming_assignments }
    end
	end

	protected
	def find_section
		@section = Section.find(params['id'])
	end
	
	def past_assignments
		return @section.past_assignments.desc(:due_date)
	end
	
	def current_assignment
		return @section.current_assignment
	end
	
	def upcoming_assignments(limit=2)
		limit ||= params['limit'] || 2
		@section.upcoming_assignments.asc(:due_date).limit(limit)
	end

end
