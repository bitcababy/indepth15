class CoursesController < ApplicationController
	before_filter :find_course, except: [:list]
	
	def list
		@courses = Course.in_catalog.asc(:course_number)
	end
	
	def home
	end
	
	def find_course
		n = params[:course_number]
		@course = Course.find_by(number: n)
	end
end
