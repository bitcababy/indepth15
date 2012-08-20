require 'spec_helper'

describe TeachersController do

	describe "GET show" do
		it "returns http success" do
			teacher = Fabricate :teacher
			get :show, id: teacher.to_param
			response.should be_success
		end
	end

end
