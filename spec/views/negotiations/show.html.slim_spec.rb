require 'spec_helper'

describe "negotiations/show" do
  before(:each) do
    @negotiation = assign(:negotiation, stub_model(Negotiation))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
