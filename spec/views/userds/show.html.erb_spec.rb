require 'spec_helper'

describe "userds/show" do
  before(:each) do
    @userd = assign(:userd, stub_model(Userd))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
