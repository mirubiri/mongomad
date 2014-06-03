require 'rails_helper'

describe "negotiations/new", :type => :view do
  before(:each) do
    assign(:negotiation, stub_model(Negotiation).as_new_record)
  end

  it "renders new negotiation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", negotiations_path, "post" do
    end
  end
end
