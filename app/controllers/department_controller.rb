class DepartmentController < ApplicationController
	
	def home_page
		dept = Department.first
    @panes = [dept.how_doc, dept.why_doc, dept.resources_doc, 
                dept.news_doc, dept.puzzle_doc]
		respond_to do |format|
			format.html { render }
			format.json { render json: @panes}
		end
		return
	end

  def about
  end
end
