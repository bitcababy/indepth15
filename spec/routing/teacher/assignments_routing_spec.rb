require "spec_helper"

describe Teacher::AssignmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/teacher/assignments").should route_to("teacher/assignments#index")
    end

    it "routes to #new" do
      get("/teacher/assignments/new").should route_to("teacher/assignments#new")
    end

    it "routes to #show" do
      get("/teacher/assignments/1").should route_to("teacher/assignments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/teacher/assignments/1/edit").should route_to("teacher/assignments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/teacher/assignments").should route_to("teacher/assignments#create")
    end

    it "routes to #update" do
      put("/teacher/assignments/1").should route_to("teacher/assignments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/teacher/assignments/1").should route_to("teacher/assignments#destroy", :id => "1")
    end

  end
end
