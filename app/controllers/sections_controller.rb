class SectionsController < ApplicationController
	before_filter :find_section, except: [:assignments]

	def assignments
		@section = Section.find_by course_id: params[:course_id].to_i, academic_year: params[:year].to_i, teacher_id: params[:teacher_id], block: params[:block].upcase
    @course = @section.course
		respond_to do |format|
			format.html {render file: 'courses/home'}
		end
	end

	# protected
	def find_section
		return @section = Section.find(params[:id])
	end

end
