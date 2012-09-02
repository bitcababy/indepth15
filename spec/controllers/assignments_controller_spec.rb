require 'spec_helper'

describe AssignmentsController do

  describe "GET 'show'" do
    it "returns http success" do
			pending "Unfinished test"
      get 'show'
      response.should be_success
    end
  end

  describe "POST 'create' XHR" do
    it "returns http success" do
			Fabricate :teacher, login: 'davidsonl'
      xhr :post, :create, {"assignment"=>{"assgt_id"=>"614639", "teacher_id"=>"davidsonl", "content"=>"This is the content of the assignment"}}
 			Assignment.where(assgt_id: 614639).exists?.should be_true
     	response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
			pending "Unfinished test"
      get 'update'
      response.should be_success
    end
  end

end
