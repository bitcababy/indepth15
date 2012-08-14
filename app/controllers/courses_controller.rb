class CoursesController < ApplicationController
	before_filter :find_course
	
	def page
		respond_to do |format|
      format.html
    end
	end

	def list
		@courses = Course.in_catalog.asc(:number)
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
	
	def find_course
		@course = Course.find(params['id'])
	end
	
end
