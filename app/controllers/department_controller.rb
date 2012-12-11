class HomeController < ApplicationController
	
		@department = Department.first
	def home_page
		respond_to do |format|
			format.html { render }
			format.json { render json: @department}
		end
		return
	end

  def about
  end
end
