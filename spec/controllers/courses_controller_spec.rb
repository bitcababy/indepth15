require 'spec_helper'

describe CoursesController do
  describe "GET 'home'" do
    it "returns http success if the course exists" do
      course = mock('course') do
        stubs(:to_param).returns 1
      end
      Course.stubs(:find).returns course
      get 'home', id: course.to_param
			assigns[:course].should == course
      response.should be_success
      response.should render_template('home')
    end
  end
  
  describe "GET 'home_with_assignments" do
    it "sets the section and returns the home page" do
      Section.stubs(:find_by).returns "bar"
      Course.stubs(:find).returns "foo"
      as_user do
        get 'home_with_assignments', id: 1, year: 2013, teacher_id: 'doej', block: 'B'
      end
      response.should be_success
      response.should render_template('home_with_assignments')
    end
  end

  # describe "GET 'resources_pane'" do
  #   it "returns http success" do
  #       get 'resources_pane', id: @course.to_param
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'information_pane'" do
  #   it "returns http success" do
  #       get 'information_pane', id: @course.to_param
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'sections_pane'" do
  #   it "returns http success" do
  #       get 'sections_pane', id: @course.to_param
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'news_pane'" do
  #   it "returns http success" do
  #       get 'news_pane', id: @course.to_param
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'policies_pane'" do
  #   it "returns http success" do
  #       get 'policies_pane', id: @course.to_param
  #     response.should be_success
  #   end
  # end

end
