require 'spec_helper'

describe "deals/new" do
  before(:each) do
    assign(:deal, stub_model(Deal).as_new_record)
  end

  it "renders new deal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", deals_path, "post" do
    end
  end
end
