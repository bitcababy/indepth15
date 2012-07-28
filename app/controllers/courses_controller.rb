class CoursesController < ApplicationController
	before_filter :find_course, only: []
	
	def list
		@courses = Course.in_catalog.asc(:number)
	end
	
	def home
		course = Course.where(number: params['course_number']).first
		respond_to do |format|
      format.html
    end
	end
	
	def resources_pane
		respond_to do |format|
      format.html
    end
	end
	
	def information_pane
		respond_to do |format|
      format.html
    end
	end
	
	def news_pane
		respond_to do |format|
      format.html
    end
	end
	
	def policies_pane
		respond_to do |format|
      format.html
    end
	end

	def sections_pane
		respond_to do |format|
      format.html
    end
	end
	
	private
	def find_course
		n = params[:id]
		@course = Course.find(n)
	end
end
