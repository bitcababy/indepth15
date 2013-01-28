require 'spec_helper'

describe SectionAssignmentsController do
  before :each do
    @section = mock('Section') do
      stubs(:to_param).returns 1
    end
    SectionAssignment.stubs(:find).returns @section
  end
    
  describe "GET 'edit'" do
    it "returns http success" do
      as_user do
        get 'edit', id: @section.to_param
      end
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      @section.stubs(:update_attributes).returns true
      subject.stubs(:redirect_to)
      as_user do
        get 'update', id: @section.to_param, section_assignment: []
      end
      response.should be_success
    end
  end


end
