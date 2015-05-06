require 'spec_helper'

describe SectionAssignmentsController do
  include DeviseHelpers

  before :each do
    @sa = Fabricate :section_assignment, assigned: true
  end
    
  describe "PUT 'update'" do
    login_user
    it "returns http success" do
      session[:goto_url] = "/"
      put 'update', {id: @sa.to_param, section_assignment: [name: "foo"]}
      expect(response).to redirect_to '/'
    end
  end

end
