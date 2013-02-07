require 'spec_helper'

describe DepartmentDocumentsController do
  include DeviseHelpers
  before :each do
    @dept = Fabricate :department_with_docs
  end

  describe '#edit, logged in' do
    login_user
    it "gets the doc referenced by params[:doc_id]" do
      doc = @dept.homepage_docs.first
      xhr :get, :edit, dept_id: @dept.to_param, id: doc.to_param
      assigns(:doc).should == doc
    end
  end
  
  describe '#save, logged_in' do
    login_user
    it "updates the doc" do
      doc = @dept.homepage_docs.first
      pending
      # put :update, dept_id: @dept.to_param, id: doc.to_param, department_document: {title: "Foo" }
      xhr :put, :update, dept_id: @dept.to_param, id: doc.to_param, department_document: {title: "Foo" }
      assigns(:doc).should == doc
    end
  end
      
end
