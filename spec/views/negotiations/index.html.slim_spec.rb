require 'rails_helper'

describe "negotiations/index", :type => :view do
  before(:each) do
    assign(:negotiations, [
      stub_model(Negotiation),
      stub_model(Negotiation)
    ])
  end

  it "renders a list of negotiations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
