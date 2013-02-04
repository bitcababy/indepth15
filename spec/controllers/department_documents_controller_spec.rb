require 'spec_helper'

describe DepartmentDocumentsController do
  include DeviseHelpers
  before :each do
    @doc = Fabricate :department_document
  end

  describe '#edit, logged in' do
    login_user

    it "gets the doc referenced by params[:doc_id]" do
      get :edit, id: @doc.to_param
      assigns(:doc).should == @doc
    end
  end
  
  describe '#save, logged_in' do
    login_user
    it "updates the doc" do
      session[:goto_url] = "/"
      put :update, id: @doc.to_param, department_document: {title: "Foo" }
      response.should redirect_to "/"
    end
  end
      

end
