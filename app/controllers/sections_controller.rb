class SectionsController < ApplicationController

	def assignments
		@section = Section.find(params['id'])
		@upcoming_assignments = @section.section_assignments.upcoming.asc(:due_date)
		@current_assignment =  @section.section_assignments.current
		@past_assignments = @section.section_assignments.past.desc(:due_date).limit(Settings.past_assts_num)
		
    respond_to do |format|
      format.html # index.html.haml
    end
	end

end
