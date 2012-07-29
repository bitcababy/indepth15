class AssignmentsController < ApplicationController
	
	def page
		course_number = params['course_number'].to_i
		block = params['block']
		year = params['year'] || Settings.academic_year
	
		course = Course.find_by(number: course_number)
		rails "Course not found: #{course_number}" unless course
		@section = course.sections.where(academic_year: year, block: block).first
		raise "section not found: #{course_number}/#{block}" unless @section

		@upcoming_assignments = @section.section_assignments.upcoming.asc(:due_date)
		@current_assignment =  @section.section_assignments.current
		@past_assignments = @section.section_assignments.past.desc(:due_date).limit(Settings.past_assts_num)

		respond_to do |format|
      format.html
    end
		
	end

end
