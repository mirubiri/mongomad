require "spec_helper"

describe NegotiationsController do
  describe "routing" do

    it "routes to #index" do
      get("/negotiations").should route_to("negotiations#index")
    end

    it "routes to #new" do
      get("/negotiations/new").should route_to("negotiations#new")
    end

    it "routes to #show" do
      get("/negotiations/1").should route_to("negotiations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/negotiations/1/edit").should route_to("negotiations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/negotiations").should route_to("negotiations#create")
    end

    it "routes to #update" do
      put("/negotiations/1").should route_to("negotiations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/negotiations/1").should route_to("negotiations#destroy", :id => "1")
    end
  end
end
