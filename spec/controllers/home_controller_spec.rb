require 'spec_helper'

describe HomeController do
	
	it {should respond_to(:user_signed_in?)}

  describe "GET 'menu'" do
			
   end

  describe "GET 'login'" do
    it "returns http success" do
      get 'login'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

end
