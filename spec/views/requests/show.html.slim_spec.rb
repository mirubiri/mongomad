require 'rails_helper'

describe "requests/show", :type => :view do
  before(:example) do
    @request = assign(:request, stub_model(Request))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
