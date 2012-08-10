class SectionsController < ApplicationController

	def assignments
		@section = Section.find(params['id'])
		
    respond_to do |format|
      format.html # assignments.html.haml
    end
	end

end
