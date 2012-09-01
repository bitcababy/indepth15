class CoursesController < ApplicationController
	before_filter :find_course, except: [:assignments_pane]
	before_filter :authenticate_user!, only: [:new]
	
	##
	## Rest routes
	##
		
	def show
		respond_to do |format|
      format.html { render }
			format.json { render json: @course}
    end
	end
	
 	# POST courses
  # POST courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

	# GET courses/new
  # GET courses/new.json
  def new
    @course = Course.new(params[:course])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # PUT courses/1
  # PUT courses/1.json
  def update
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to course_url(@course), notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

	##
	## Other methods
	##
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
