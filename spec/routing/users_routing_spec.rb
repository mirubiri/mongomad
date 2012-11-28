require "spec_helper"

describe UsersController do

  describe "routing" do

    it "routes to users#index" do
      get("/users").should route_to("users#index")
    end

    it "routes to users#new" do
      get("/users/new").should route_to("users#new")
    end

    it "routes to users#show" do
      get("/users/1").should route_to("users#show", :id => "1")
    end

    it "routes to users#edit" do
      get("/users/1/edit").should route_to("users#edit", :id => "1")
    end

    it "routes to users#create" do
      post("/users").should route_to("devise/registrations#create")
    end

    it "routes to users#update" do
      put("/users/1").should route_to("users#update", :id => "1")
    end

    it "routes to users#destroy" do
      delete("/users/1").should route_to("users#destroy", :id => "1")
    end    

  end
end
