class SectionsController < ApplicationController
  before_filter :authenticate_user!, only: []
	before_filter :find_section, except: [:retrieve]

  def assignments_pane
    remember_current_page
    @current = @section.current_assignments
    @upcoming =  @section.upcoming_assignments
    @past = @section.past_assignments
    unless user_signed_in?
      @current = @current.assigned unless @current.empty?
      @upcoming = @upcoming.assigned unless @upcoming.empty?
      @past = @past.assigned unless @past.empty?
    end
     
    respond_to do |format|
      format.html {render layout: !request.xhr?}
    end
  end
 
	# protected
	def find_section
		return @section = Section.find(params[:id])
	end

end
