require 'spec_helper'

describe DepartmentDocumentsController do
  include DeviseHelpers
  login_user

  before :each do
    @dept = Fabricate :department_with_docs
  end

  describe '#edit, logged in' do
    it "gets the doc referenced by params[:doc_id]" do
      doc = @dept.homepage_docs.first
      expect(doc).to_not be_nil
      xhr :get, :edit, dept_id: @dept.to_param, id: doc.to_param
      expect(assigns(:doc)).to eq doc
    end
  end

  describe '#save, logged_in' do
    it "updates the doc" do
      doc = @dept.homepage_docs.first
      pending
      xhr :put, :update, dept_id: @dept.to_param, id: doc.to_param
      expect(assigns(:doc)).to eq doc
      expect(response).to =~ /.*\/home$/
    end
  end
      
end
