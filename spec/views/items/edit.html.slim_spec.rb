require 'rails_helper'

describe "items/edit", :type => :view do
  before(:example) do
    @item = assign(:item, stub_model(Item))
  end

  it "renders the edit item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", item_path(@item), "post" do
    end
  end
end
