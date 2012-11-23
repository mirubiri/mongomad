require 'spec_helper'

describe "negotiations/edit" do
  before(:each) do
    @negotiation = assign(:negotiation, stub_model(Negotiation))
  end

  it "renders the edit negotiation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => negotiations_path(@negotiation), :method => "post" do
    end
  end
end
