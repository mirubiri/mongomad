require "spec_helper"

describe OffersController do

  describe "routing" do

    it "routes to users/offers#index" do
      get("/users/1/offers").should route_to("offers#index",  :user_id => "1")
    end

    it "routes to users/offers#new" do
      get("/users/1/offers/new").should route_to("offers#new",  :user_id => "1")
    end

    it "routes to users/offers#show" do
      get("/users/1/offers/1").should route_to("offers#show",  :user_id => "1",:id => "1")
    end

    it "routes to users/offers#edit" do
      get("/users/1/offers/1/edit").should route_to("offers#edit", :user_id => "1",:id => "1")
    end

    it "routes to users/offers#create" do
      post("/users/1/offers").should route_to("offers#create",  :user_id => "1")
    end

    it "routes to users/offers#update" do
      put("/users/1/offers/1").should route_to("offers#update", :user_id => "1",:id => "1")
    end

    it "routes to users/offers#destroy" do
      delete("/users/1/offers/1").should route_to("offers#destroy",  :user_id => "1",:id => "1")
    end

  end
end
