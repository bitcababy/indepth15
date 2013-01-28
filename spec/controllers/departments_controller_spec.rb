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
      @doc = Fabricate :department_document
    end

    it "gets the doc referenced by params[:doc_id]" do
      as_user do
        get :edit_doc, doc_id: @doc.to_param
      end
      assigns(:doc).should == @doc
    end
    
  end
	
end
