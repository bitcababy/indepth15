class Admin::CoursesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_course, except: [:create, :index, :new]

  # GET /admin/courses
  # GET /admin/courses.json
  def index
    @courses = ::Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /admin/courses/1
  # GET /admin/courses/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /admin/courses/new
  # GET /admin/courses/new.json
  def new
    @course = ::Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /admin/courses/1/edit
  def edit
  end

  # POST /admin/courses
  # POST /admin/courses.json
  def create
    @course = ::Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to admin_course_url(@course), notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/courses/1
  # PUT /admin/courses/1.json
  def update
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to admin_course_url(@course), notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/courses/1
  # DELETE /admin/courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to admin_courses_url }
      format.json { head :no_content }
    end
  end

	def find_course
    @course = ::Course.find(params[:id])
	end
end
