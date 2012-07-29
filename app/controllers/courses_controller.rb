class CoursesController < ApplicationController
	before_filter :find_course, except: [:list]
	
	def list
		@courses = Course.in_catalog.asc(:number)
	end
	
	def home
		respond_to do |format|
      format.html
    end
	end
	
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
	
	private
	def find_course
		n = params[:id]
		@course = Course.find(n)
	end
end
