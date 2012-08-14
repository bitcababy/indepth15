require 'spec_helper'

describe TeachersController do

	describe "GET home" do
		it "returns http success" do
			teacher = Fabricate :teacher
			get :home, id: teacher.to_param
			response.should be_success
		end
	end

end
