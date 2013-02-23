class CoursesController < ApplicationController
	before_filter :find_course, except: []
	before_filter :authenticate_user!, only: []
	
	def home
    remember_current_page
    @section = get_section
 		respond_to do |format|
			format.html { render }
			format.json { render json: @course}
		end
	end

  def get_pane
    kind = params[:kind]
    if kind == 'sections'
      respond_to do |format|
        format.html { render partial: "courses/sections_pane", locals: {course: @course }}
      end
    else
      pane = @course.doc_of_kind kind
      respond_to do |format|
        format.html { render partial: "courses/pane", locals: {pane: pane }}
      end
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
  
  def get_section
    if params[:teacher_id] && params[:teacher_id] && params[:block] && params[:year]
      return Section.find_by course: @course, teacher: params[:teacher_id], block: params[:block], academic_year: params[:year]
    else
      return nil
    end
  end
	
	def find_course
		@course = Course.find(params[:id])
	end
	
end
