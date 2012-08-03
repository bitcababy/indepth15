require 'spec_helper'


describe TeachersController do

	describe "GET home" do
		it "returns http success" do
			pending "Unfinished test"
			teacher = Fabricate :teacher
			visit home_teacher_path(teacher)
			response.should be_success
		end
	end

end
