require 'rails_helper'

describe "deals/edit", :type => :view do
  before(:example) do
    @deal = assign(:deal, stub_model(Deal))
  end

  it "renders the edit deal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", deal_path(@deal), "post" do
    end
  end
end
