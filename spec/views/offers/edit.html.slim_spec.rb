require 'rails_helper'

describe "offers/edit", :type => :view do
  before(:each) do
    @offer = assign(:offer, stub_model(Offer))
  end

  it "renders the edit offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", offer_path(@offer), "post" do
    end
  end
end
