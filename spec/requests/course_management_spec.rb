require 'spec_helper'

describe 'Course management', 'non-admin' do
	it "shows a course page" do
		pending "Unfinished test"
		course = Fabricate(:course)
		get home_course(course)
		response.should render_template(:home)
	end
end
		
describe "Course management", 'admin' do
	it "creates a Course and redirects to the Course's page" do
		pending "Unfinished test"
    get "/admin/courses/new"
    response.should render_template(:new)
    post "/admin/courses", :courses => {:name => "My Widget"}

    response.should redirect_to(assigns(:course))
    follow_redirect!

    response.should render_template(:show)
    response.body.should include("Widget was successfully created.")
	end
end