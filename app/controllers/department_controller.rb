class HomeController < ApplicationController
	
	def dept_info
		@department = Department.first
		respond_to do |format|
			format.html { render }
			format.json { render json: @department}
		end
		return
	end

  def about
  end
end
