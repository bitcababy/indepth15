require 'spec_helper'

describe Teacher::CoursesController do
	login_teacher
	it_behaves_like "any teacher controller"

end
