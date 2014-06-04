require 'rails_helper'

describe "deals/index", :type => :view do
  before(:example) do
    assign(:deals, [
      stub_model(Deal),
      stub_model(Deal)
    ])
  end

  it "renders a list of deals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
