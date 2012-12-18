class DepartmentController < ApplicationController
	before_filter :find_department, except: []
	
	def home
		respond_to do |format|
			format.html { render }
			format.json { render json: @panes}
		end
		return
	end

  def about
  end
  
  protected
  def find_department
    @dept = Department.first
  end

end
