require 'rails_helper'

describe "offers/show", :type => :view do
  before(:example) do
    @offer = assign(:offer, stub_model(Offer))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
