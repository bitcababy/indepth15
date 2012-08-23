class CoursesController < ApplicationController
	before_filter :find_course, except: [:assignments_pane]
	before_filter :authenticate_user!, only: []
		
	def show
		respond_to do |format|
      format.html
    end
	end
	
	def assignments_pane
		@section = Section.find(params[:section_id])
		@course = @section.course
		@selected = 5
		respond_to do |format|
      format.html { render :layout => !request.xhr? }
     end
	end

	# Panes
	def resources_pane
		respond_to do |format|
      format.html { render :layout => !request.xhr? }
     end
	end
	
	def information_pane
		respond_to do |format|
      format.html { render :layout => !request.xhr? }
    end
	end
	
	def news_pane
		respond_to do |format|
      format.html { render :layout => !request.xhr? }
    end
	end
	
	def policies_pane
		respond_to do |format|
      format.html { render :layout => !request.xhr? }
    end
	end

	def sections_pane
		respond_to do |format|
      format.html { render :layout => !request.xhr? }
    end
	end
	
	protected
	def find_course
		@course = Course.find(params['id'])
	end
	
end
