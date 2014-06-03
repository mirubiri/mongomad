require 'rails_helper'

describe "negotiations/edit", :type => :view do
  before(:each) do
    @negotiation = assign(:negotiation, stub_model(Negotiation))
  end

  it "renders the edit negotiation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", negotiation_path(@negotiation), "post" do
    end
  end
end
