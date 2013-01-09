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
      subject.current_user.should be_nil
      doc = Fabricate :text_document
      get :edit_doc, doc_id: doc.to_param
      assigns(:doc).should == doc
    end
    it "locks the document if it's unlocked and returns an edit form" do
      doc = Fabricate :text_document
      get :edit_doc, doc_id: doc
      response.should render_template :edit_doc
    end
      
    it "returns :bad_request if the document is locked" do
      doc = Fabricate :locked_doc
      doc.stubs(:locked?).returns(true)
      doc.stubs(:can_relock?).returns(false)
      get :edit_doc, doc_id: doc.to_param
      response.should_not render_template :edit_doc
      assert_response :bad_request
    end
  end
	
end
