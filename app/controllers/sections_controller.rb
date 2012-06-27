class SectionsController < ApplicationController
	before_filter :find_section
	
  def assignments
		@upcoming_assignments = @section.section_assignments.future.asc(:due_date)
		@current_assignment = @upcoming_assignments.shift
		@past_assignments = @section.section_assignments.future.desc(:due_date).limit(Settings.past_assts_num)
  end

	private
	def find_section
		n = params[:id]
		@section = Section.find(n)
	end
end
