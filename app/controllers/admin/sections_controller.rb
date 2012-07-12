class Admin::SectionsController < ApplicationController
	before_filter :find_section, :only => [:edit, :update, :destroy]
	before_filter :find_course, :only => [:new]

  def create
  end

  def new
		@section = Section.new(course: @course)
		render :edit
  end

  def edit
		respond_to do |format|
      format.html
    end
  end

  def update
  end

  def destroy
  end

	private

	def find_section
		n = params[:id]
		@section = Section.find(n)
	end

	def find_course
		n = params[:course_id]
		@course = Course.find(n)
	end

end
