require "spec_helper"

describe DealsController do

  describe "routing" do

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

  end
end
