class SectionsController < ApplicationController
	before_filter :find_section, except: [:assignments]

	def assignments_pane
		@course = @section.course
    respond_to do |format|
      format.html {render :layout => !request.xhr?}
    end
	end
	
	def assignments
		@section = Section.find_by course_id: params[:course_id].to_i, academic_year: params[:year].to_i, teacher_id: params[:teacher_id], block: params[:block].upcase
		respond_to do |format|
			format.html {render :layout => !request.xhr?}
		end
	end

	# protected
	def find_section
		@section = Section.find(params[:id])
	end

end
