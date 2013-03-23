class SectionsController < ApplicationController
  before_filter :authenticate_user!, only: []
	before_filter :find_section

  def assignments_pane
     @course = @section.course
     respond_to do |format|
       format.html {render layout: !request.xhr?}
     end
   end
    if params[:year]
      ss =  Section.retrieve(year: params[:year], teacher: params[:teacher], course: params[:course], block: params[:block], limit: params[:limit])
    else
      ss =  Section.retrieve(teacher: params[:teacher], course: params[:course], block: params[:block], limit: params[:limit)
    end
    
    respond_to do |format|
      format.any { render json: ss }
    end
  end
 
	# protected
	def find_section
		return @section = Section.find(params[:id])
	end

end
