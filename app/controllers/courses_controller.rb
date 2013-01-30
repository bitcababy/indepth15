class CoursesController < ApplicationController
	before_filter :find_course, except: []
	before_filter :authenticate_user!, only: []
	
	def home
		respond_to do |format|
			format.html { render }
			format.json { render json: @course}
		end
	end

  def home_with_assignments
    @section = Section.find_by course: @course, teacher: params[:teacher_id], block: params[:block], academic_year: params[:year]
		respond_to do |format|
			format.html { render }
		end
  end
  
  def get_pane
    pane = params[:pane_id]
      
    respond_to do |format|
      format.html { render partial: "courses/#{pane}_pane", locals: {course: @course }}
    end
  end
  
 
	##
	## Rest routes
	##
	# # POST courses
	#		# POST courses.json
	#		def create
	#			@course = Course.new(params[:course])
	# 
	#			respond_to do |format|
	#				if @course.save
	#					format.html { redirect_to course_url(@course), notice: 'Course was successfully created.' }
	#				format.js
	#					format.json { render json: @course, status: :created, location: @course }
	#				else
	#					format.html { render action: "new" }
	#					format.js
	#					format.json { render json: @course.errors, status: :unprocessable_entity }
	#				end
	#			end
	#		end
	# 
	# # GET courses/new
	#		# GET courses/new.json
	#		def new
	#			@course = Course.new(params[:course])
	#			respond_to do |format|
	#				format.html # new.html.erb
	#				format.json { render json: @course }
	#			end
	#		end
	# 
	#		# PUT courses/1
	#		# PUT courses/1.json
	#		def update
	#			respond_to do |format|
	#				if @course.update_attributes(params[:course])
	#					format.html { redirect_to course_url(@course), notice: 'Course was successfully updated.' }
	#					format.json { head :no_content }
	#				else
	#					format.html { render action: "edit" }
	#					format.json { render json: @course.errors, status: :unprocessable_entity }
	#				end
	#			end
	#		end
	protected
	
	def find_course
		@course = Course.find(params[:id])
	end
	
end
