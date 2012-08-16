class Teacher::CoursesController < ApplicationController
	before_filter :authenticate_user!
	
end
