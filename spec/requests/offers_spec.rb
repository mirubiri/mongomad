require 'spec_helper'

describe "Offers", :type => :request do
  describe "GET /offers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get offers_path
      expect(response.status).to be(200)
    end
  end
end
