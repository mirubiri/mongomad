require "spec_helper"

describe UserdsController do
  describe "routing" do

    it "routes to #index" do
      get("/userds").should route_to("userds#index")
    end

    it "routes to #new" do
      get("/userds/new").should route_to("userds#new")
    end

    it "routes to #show" do
      get("/userds/1").should route_to("userds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/userds/1/edit").should route_to("userds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/userds").should route_to("userds#create")
    end

    it "routes to #update" do
      put("/userds/1").should route_to("userds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/userds/1").should route_to("userds#destroy", :id => "1")
    end

  end
end
