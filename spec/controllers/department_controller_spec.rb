require 'spec_helper'

describe DepartmentController do
  include DepartmentHelper

  describe 'GET :home' do
    it "uses the first department" do
      dept = mock_department
      Department.stubs(:first).returns dept
      get :home
      assigns(:dept).should == dept
    end
  end  
	
end
