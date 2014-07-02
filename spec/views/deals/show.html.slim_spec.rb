require 'rails_helper'

describe "deals/show", :type => :view do
  before(:example) do
    @deal = assign(:deal, stub_model(Deal))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
