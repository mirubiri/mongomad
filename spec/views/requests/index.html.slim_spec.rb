require 'rails_helper'

describe "requests/index", :type => :view do
  before(:example) do
    assign(:requests, [
      stub_model(Request),
      stub_model(Request)
    ])
  end

  it "renders a list of requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
