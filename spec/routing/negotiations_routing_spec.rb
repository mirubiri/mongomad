require "spec_helper"

describe NegotiationsController do

  describe "routing" do

    it "routes to #index" do
      get("/users/1/negotiations").should route_to("negotiations#index",  :user_id => "1")
    end

    it "routes to users/negotiations#new" do
      get("/users/1/negotiations/new").should route_to("negotiations#new",  :user_id => "1")
    end

    it "routes to users/negotiations#show" do
      get("/users/1/negotiations/1").should route_to("negotiations#show",  :user_id => "1",:id => "1")
    end

    it "routes to users/negotiations#edit" do
      get("/users/1/negotiations/1/edit").should route_to("negotiations#edit",  :user_id => "1", :id => "1")
    end

    it "routes to users/negotiations#create" do
      post("/users/1/negotiations").should route_to("negotiations#create",  :user_id => "1")
    end

    it "routes to users/negotiations#update" do
      put("/users/1/negotiations/1").should route_to("negotiations#update",  :user_id => "1", :id => "1")
    end

    it "routes to users/negotiations#destroy" do
      delete("/users/1/negotiations/1").should route_to("negotiations#destroy",  :user_id => "1", :id => "1")
    end
    
  end
end
