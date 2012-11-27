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

    #rutas de las negociaciones de un usuario

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

    #rutas de los tratos de un usuario

    it "routes to users/deals#index" do
      get("/users/1/deals").should route_to("deals#index",  :user_id => "1")
    end

    it "routes to users/deals#new" do
      get("/users/1/deals/new").should route_to("deals#new",  :user_id => "1")
    end

    it "routes to users/deals#show" do
      get("/users/1/deals/1").should route_to("deals#show",  :user_id => "1", :id => "1")
    end

    it "routes to users/deals#edit" do
      get("/users/1/deals/1/edit").should route_to("deals#edit",  :user_id => "1", :id => "1")
    end

    it "routes to users/deals#create" do
      post("/users/1/deals").should route_to("deals#create",  :user_id => "1")
    end

    it "routes to users/deals#update" do
      put("/users/1/deals/1").should route_to("deals#update",  :user_id => "1", :id => "1")
    end

    it "routes to users/deals#destroy" do
      delete("/users/1/deals/1").should route_to("deals#destroy",  :user_id => "1", :id => "1")
    end

    #rutas de las peticiones de un usuario

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
