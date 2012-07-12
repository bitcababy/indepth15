require 'spec_helper'

describe MenubarController do

  describe "GET 'display'" do
    it "returns http success" do
      get 'display'
      response.should be_success
    end
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'courses'" do
    it "returns http success" do
      get 'courses'
      response.should be_success
    end
  end

  describe "GET 'faculty'" do
    it "returns http success" do
      get 'faculty'
      response.should be_success
    end
  end

  describe "GET 'admin'" do
    it "returns http success" do
      get 'admin'
      response.should be_success
    end
  end

end
