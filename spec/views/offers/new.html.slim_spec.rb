require 'rails_helper'

describe "offers/new", :type => :view do
  before(:each) do
    assign(:offer, stub_model(Offer).as_new_record)
  end

  it "renders new offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", offers_path, "post" do
    end
  end
end
