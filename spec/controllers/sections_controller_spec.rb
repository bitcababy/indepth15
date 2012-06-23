require 'spec_helper'

describe SectionsController do

  describe "GET 'assignments'" do
    it "returns http success" do
      get 'assignments'
      response.should be_success
    end
  end

end
