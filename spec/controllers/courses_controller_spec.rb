require 'spec_helper'

describe CoursesController do

	context "single course" do
		before :each do
			@course = Fabricate :course
		end

	  describe "GET 'home'" do
	    it "returns http success" do
	      visit course_home_path(@course)
	      response.should be_success
	    end
	  end

	  describe "GET 'resources_pane'" do
	    it "returns http success" do
	      visit course_resources_pane_path(@course)
	      response.should be_success
	    end
	  end

	  describe "GET 'information_pane'" do
	    it "returns http success" do
	      visit course_information_pane_path(@course)
	      response.should be_success
	    end
	  end

	  describe "GET 'sections_pane'" do
	    it "returns http success" do
	      visit course_sections_pane_path(@course)
	      response.should be_success
	    end
	  end

	  describe "GET 'news_pane'" do
	    it "returns http success" do
	      visit course_news_pane_path(@course)
	      response.should be_success
	    end
	  end

	  describe "GET 'policies_pane'" do
	    it "returns http success" do
	      visit course_policies_pane_path(@course)
	      response.should be_success
	    end
	  end
	end

end
