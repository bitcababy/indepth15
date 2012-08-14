class Teacher::SectionsController < ApplicationController
 	before_filter :authenticate_user!
	before_filter :find_section, only: [:show, :edit, :update, :destroy]

 # GET /teacher/sections
  # GET /teacher/sections.json
  def index
    @sections = Section.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sections }
    end
  end

  # GET /teacher/sections/1
  # GET /teacher/sections/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @section }
    end
  end

  # GET /teacher/sections/new
  # GET /teacher/sections/new.json
  def new
    @section = Section.new(params[:section])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @section }
    end
  end

  # GET /teacher/sections/1/edit
  def edit
  end

  # POST /teacher/sections
  # POST /teacher/sections.json
  def create
    @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        format.html { redirect_to teacher_section_url(@section), notice: 'Section was successfully created.' }
        format.json { render json: @section, status: :created, location: @section }
      else
        format.html { render action: "new" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teacher/sections/1
  # PUT /teacher/sections/1.json
  def update
    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to teacher_section_url(@section), notice: 'Section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher/sections/1
  # DELETE /teacher/sections/1.json
  def destroy
    @section.destroy

    respond_to do |format|
      format.html { redirect_to teacher_sections_url }
      format.json { head :no_content }
    end
  end

	def find_section
    @section = Section.find(params[:id])
	end

end
