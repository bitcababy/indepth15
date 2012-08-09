require 'spec_helper'

describe AssignmentsController do
	context "guest accessible areas"
	context "teacher accessible areas"
	context "admin accessible areas" do
		login_teacher
			
		it "should get index" do
			get 'index'
			response.should be_success
		end
	end
end
