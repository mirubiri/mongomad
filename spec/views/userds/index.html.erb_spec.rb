require 'spec_helper'

describe "userds/index" do
  before(:each) do
    assign(:userds, [
      stub_model(Userd),
      stub_model(Userd)
    ])
  end

  it "renders a list of userds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
