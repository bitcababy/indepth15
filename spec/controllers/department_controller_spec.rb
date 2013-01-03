require 'spec_helper'

describe DepartmentController do
  include DepartmentHelper

  describe 'GET :home' do
    it "uses the first department" do
      dept = Fabricate :department
      get :home
      assigns(:dept).should == dept
    end
  end
  
	
end
