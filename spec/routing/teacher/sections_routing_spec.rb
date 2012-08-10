require "spec_helper"

describe Teacher::SectionsController do
  describe "routing" do

    it "routes to #index" do
      get("/teacher/sections").should route_to("teacher/sections#index")
    end

    it "routes to #new" do
      get("/teacher/sections/new").should route_to("teacher/sections#new")
    end

    it "routes to #show" do
      get("/teacher/sections/1").should route_to("teacher/sections#show", :id => "1")
    end

    it "routes to #edit" do
      get("/teacher/sections/1/edit").should route_to("teacher/sections#edit", :id => "1")
    end

    it "routes to #create" do
      post("/teacher/sections").should route_to("teacher/sections#create")
    end

    it "routes to #update" do
      put("/teacher/sections/1").should route_to("teacher/sections#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/teacher/sections/1").should route_to("teacher/sections#destroy", :id => "1")
    end

  end
end
