class CoursesController < ApplicationController
	before_filter :find_course, except: [:index, :list, :new, :create]
	# skip_before_filter :verify_authenticity_token, :except => [:home, :list]
	
	def home
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
	
	# GET /courses
  # GET /courses.json
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
		puts params[:course]
		return
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

	private
	def find_course
		n = params[:id]
		@course = Course.find(n)
	end
end
