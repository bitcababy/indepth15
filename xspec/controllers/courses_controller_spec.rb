require 'spec_helper'

describe CoursesController do
  describe "GET 'home'" do
    it "returns http success if the course exists" do
      course = mock_model 'Course'
      course.stub(:to_param).and_return 1
      course.stub(:year).and_return Settings.academic_year
      Course.stub(:find).and_return course
      get 'home', id: course.to_param
			expect(assigns[:course]).to eq course
      expect(response).to be_success
      expect(response).to render_template('home')
    end
    it "sets the section and returns the home page if section params are passed" do
      Section.stub(:find_by).and_return "bar"
      Course.stub(:find).and_return "foo"
      get :home, id: 1, teacher_id: 'doej', block: 'B'
      expect(response).to be_success
      expect(response).to render_template('home')
    end
  end
  
  describe '/course/:id/get_pane:kind' do
    it "returns the contents of a pane" do
      course = mock_model 'Course'
      course.stub(:to_param).and_return 1
      course.stub(:doc_of_kind).and_return "foo"
      Course.stub(:find).and_return course
      xhr :get, :get_pane, id: course.to_param, kind: :foo
      expect(response).to be_success
    end
  end
      
end
