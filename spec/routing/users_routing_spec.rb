require "spec_helper"

describe UsersController do

  describe "routing" do

    #rutas del usuario a pelo, xD

    it "routes to #index" do
      get("/users").should route_to("users#index")
    end

    it "routes to #new" do
      get("/users/new").should route_to("users#new")
    end

    it "routes to #show" do
      get("/users/1").should route_to("users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/users/1/edit").should route_to("users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/users").should route_to("devise/registrations#create")
    end

    it "routes to #update" do
      put("/users/1").should route_to("users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/users/1").should route_to("users#destroy", :id => "1")
    end

    #rutas de las ofertas de un usuario

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
