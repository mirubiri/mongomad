require "spec_helper"

describe NegotiationsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/negotiations")).to route_to("negotiations#index")
    end

    it "routes to #new" do
      expect(get("/negotiations/new")).to route_to("negotiations#new")
    end

    it "routes to #show" do
      expect(get("/negotiations/1")).to route_to("negotiations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/negotiations/1/edit")).to route_to("negotiations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/negotiations")).to route_to("negotiations#create")
    end

    it "routes to #update" do
      expect(put("/negotiations/1")).to route_to("negotiations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/negotiations/1")).to route_to("negotiations#destroy", :id => "1")
    end

  end
end
