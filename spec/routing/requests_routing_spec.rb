require "spec_helper"

describe RequestsController do

  describe "routing" do

    it "routes to users/requests#index" do
      get("/users/1/requests").should route_to("requests#index",  :user_id => "1")
    end

    it "routes to users/requests#new" do
      get("/users/1/requests/new").should route_to("requests#new",  :user_id => "1")
    end

    it "routes to users/requests#show" do
      get("/users/1/requests/1").should route_to("requests#show",  :user_id => "1", :id => "1")
    end

    it "routes to users/requests#edit" do
      get("/users/1/requests/1/edit").should route_to("requests#edit",  :user_id => "1", :id => "1")
    end

    it "routes to users/requests#create" do
      post("/users/1/requests").should route_to("requests#create",  :user_id => "1")
    end

    it "routes to users/requests#update" do
      put("/users/1/requests/1").should route_to("requests#update",  :user_id => "1", :id => "1")
    end

    it "routes to users/requests#destroy" do
      delete("/users/1/requests/1").should route_to("requests#destroy",  :user_id => "1", :id => "1")
    end

  end
end
