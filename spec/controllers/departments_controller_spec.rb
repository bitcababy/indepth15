require 'spec_helper'

describe DepartmentsController do
  # 
  # get :home do
  #   should_render :home
  #   should_assign @dept, :dept => [Department, :first]
  # end

  describe 'GET :home' do
    it "show the page of the first department" do
      dept = Fabricate :department
      get :home
      assigns(:dept).should == dept
      response.should render_template :home
    end
  end
  
end
