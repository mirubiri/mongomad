require 'rails_helper'

describe "items/show", :type => :view do
  before(:example) do
    @item = assign(:item, stub_model(Item))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
