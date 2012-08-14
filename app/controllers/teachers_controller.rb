class TeachersController < ApplicationController
	def home
		@teacher = Teacher.find(params['id'])
	end
end
