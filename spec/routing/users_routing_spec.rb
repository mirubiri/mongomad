require "spec_helper"

describe UsersController do
  describe "routing" do
    let(:user_name) { Fabricate(:user).name }

    it "not routes to #index" do
      get("/users").should_not route_to("users#index")
    end

    it "routes to #new" do
      get("/new").should route_to("users#new")
    end

    it "routes to #show" do
      get("/#{user_name}").should route_to("users#show", :id => "#{user_name}")
    end

    it "routes to #edit" do
      get("#{user_name}/edit").should route_to("users#edit", :id => "#{user_name}")
    end

    it "not routes to #create" do
      post("/users").should_not route_to("users#create")
    end

    it "routes to #update" do
      put("#{user_name}").should route_to("users#update", :id => "#{user_name}")
    end

    it "routes to #destroy" do
      delete("#{user_name}").should route_to("users#destroy", :id => "#{user_name}")
    end
  end
end
