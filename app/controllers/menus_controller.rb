class MenusController < ApplicationController
	layout nil
	respond_to :html, :xml, :js

	def home
		respond_with do |format|
			format.html
			format.js {render partial: 'courses', locals: {courses: courses}, content_type: 'text/html'}
		end
	end

	def courses
		courses = Course.in_catalog
		respond_with do |format|
			format.html
			format.js {render partial: 'courses', locals: {courses: courses}, content_type: 'text/html'}
		end
	end
	
	def faculty
		teachers = Teacher.current
		respond_with do |format|
			format.html 
			format.js {render partial: 'faculty', locals: {teachers: teachers}, content_type: 'text/html'}
		end
	end
	
	def manage
		respond_with do |format|
			format.html 
			format.js {render partial: 'manage', content_type: 'text/html'}
		end
	end
	
end
