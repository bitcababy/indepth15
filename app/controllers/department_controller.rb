class DepartmentController < ApplicationController
	
	def home
		respond_to do |format|
			format.html { render }
			format.json { render json: @panes}
		end
		return
	end

  def about
  end
end
