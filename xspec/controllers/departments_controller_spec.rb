require 'spec_helper'

describe DepartmentsController do
  # 
  # get :home do
  #   should_render :home
  #   should_assign @dept, :dept => [Department, :first]
  # end
  

  describe 'GET :home' do
    before :each do
      @dept = Fabricate :department
      get :home
    end
  
    it "show the page of the first department" do
      expect(assigns(:dept)).to eq @dept
      expect(response).to render_template :home
    end
  end
  
end
