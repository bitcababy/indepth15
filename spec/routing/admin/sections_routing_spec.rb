require "spec_helper"

describe Admin::SectionsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/sections").should route_to("admin/sections#index")
    end

    it "routes to #new" do
      get("/admin/sections/new").should route_to("admin/sections#new")
    end

    it "routes to #show" do
      get("/admin/sections/1").should route_to("admin/sections#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/sections/1/edit").should route_to("admin/sections#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/sections").should route_to("admin/sections#create")
    end

    it "routes to #update" do
      put("/admin/sections/1").should route_to("admin/sections#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/sections/1").should route_to("admin/sections#destroy", :id => "1")
    end

  end
end
