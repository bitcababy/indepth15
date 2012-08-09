require 'spec_helper'

describe CoursesController do
	context "guest accessible" do
		before :each do
			@course = Fabricate :course
		end

	  describe "GET 'home'" do
	    it "returns http success" do
	      get 'home', id: @course.to_param
	      response.should be_success
	    end
	  end

	  describe "GET 'resources_pane'" do
	    it "returns http success" do
				get 'resources_pane', id: @course.to_param
	      response.should be_success
	    end
	  end

	  describe "GET 'information_pane'" do
	    it "returns http success" do
				get 'information_pane', id: @course.to_param
	      response.should be_success
	    end
	  end

	  describe "GET 'sections_pane'" do
	    it "returns http success" do
				get 'sections_pane', id: @course.to_param
	      response.should be_success
	    end
	  end

	  describe "GET 'news_pane'" do
	    it "returns http success" do
				get 'news_pane', id: @course.to_param
	      response.should be_success
	    end
	  end

	  describe "GET 'policies_pane'" do
	    it "returns http success" do
				get 'policies_pane', id: @course.to_param
	      response.should be_success
	    end
	  end

	end

end
