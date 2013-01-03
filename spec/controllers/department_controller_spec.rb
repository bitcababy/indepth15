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
  
  describe '#edit_doc' do
    it "gets the doc referenced by params[:doc_id]" do
      doc = Fabricate :text_document
      get :edit_doc, doc_id: doc
      assigns(:doc).should == doc
    end
    it "locks the document if it's unlocked and returns an edit form" do
      doc = Fabricate :text_document
      get :edit_doc, doc_id: doc
      response.should render_template :edit_doc
    end
      
    # SMELL: Not sure if this is the right way to handle it
    it "returns :bad_request if the document is locked" do
      doc = Fabricate :text_document
      doc.lock
      get :edit_doc, doc_id: doc
      assert_response :bad_request
    end
  end
	
end
