class HomeController < ApplicationController
	
	def dept_info
		@department = Department.first
	end

  def about
  end
end
