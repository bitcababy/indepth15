class AssignmentTableCell < Cell::Rails
	helper ApplicationHelper
	
	NEXT_ASSIGNMENT_ID = 'next_assignment'
	UPCOMING_ASSIGNMENTS_ID = 'upcoming_assignments'
	PAST_ASSIGNMENTS_ID = 'past_assignments'
	
	def display(sas, table_id = nil, caption=nil)
		@section_assignments = sas
		@caption = caption
		@table_id = table_id
		render view: :display
	end

end
