class SectionsController < ApplicationController
  before_filter :authenticate_user!, only: []
	before_filter :find_section, except: [:retrieve]

  def assignments_pane
    @course = @section.course
    respond_to do |format|
      format.html {render layout: !request.xhr?}
    end
  end
 
	# protected
	def find_section
		return @section = Section.find(params[:id])
	end

end
