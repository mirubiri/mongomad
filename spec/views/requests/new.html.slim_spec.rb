require 'rails_helper'

describe "requests/new", :type => :view do
  before(:each) do
    assign(:request, stub_model(Request).as_new_record)
  end

  it "renders new request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", requests_path, "post" do
    end
  end
end
