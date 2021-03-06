require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stub and message expectations in this spec. Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SectionsController do
  include SectionsHelpers

  describe "GET 'assignments_pane', xhr" do
    it "display the assignments pane" do
      section = mock_model 'Section'
      section.stub(:course).and_return "foo"
      section.stub(:to_param).and_return 1
      section.stub(:current_assignments).and_return []
      section.stub(:upcoming_assignments).and_return []
      section.stub(:past_assignments).and_return []
      Section.stub(:find).and_return(section)
      xhr :get, :assignments_pane, id: section.to_param
      expect(response).to be_success
      expect(assigns(:section)).to eq(section)
      # expect(assigns(:course)).to eq("foo")
    end
  end

  context "logged in" do
    include Warden::Test::Helpers
    login_user

    before do
      3.times { Fabricate :course }
    end

    describe "GET 'new'" do
    end
  end


end
