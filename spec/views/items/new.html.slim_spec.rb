require 'rails_helper'

describe "items/new", :type => :view do
  before(:each) do
    assign(:item, stub_model(Item).as_new_record)
  end

  it "renders new item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", items_path, "post" do
    end
  end
end
