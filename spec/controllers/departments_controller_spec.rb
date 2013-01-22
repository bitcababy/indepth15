require 'spec_helper'

describe DepartmentsController do
  include DepartmentHelper
  include DeviseHelper

  describe 'GET :home' do
    it "uses the first department" do
      dept = Fabricate :department
      get :home
      assigns(:dept).should == dept
    end
  end
  
  describe '#edit_doc, logged in' do
    before :each do
      @doc = Fabricate :text_document
      create_user
    end

    it "gets the doc referenced by params[:doc_id]" do
      get :edit_doc, doc_id: @doc.to_param
      assigns(:doc).should == @doc
    end
    
    it "locks the document if it's lockable and renders the form" do
      get :edit_doc, doc_id: @doc
      response.should render_template(:edit_doc)
      assigns(:doc).should === @doc
      assigns(:doc).should be_locked
    end
      
    it "returns :bad_request if the document is locked" do
      pending
      get :edit_doc, doc_id: @doc
      response.should_not render_template :edit_doc
      assert_response :bad_request
    end
  end
	
end
