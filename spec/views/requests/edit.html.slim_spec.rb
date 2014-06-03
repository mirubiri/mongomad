require 'rails_helper'

describe "requests/edit", :type => :view do
  before(:each) do
    @request = assign(:request, stub_model(Request))
  end

  it "renders the edit request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", request_path(@request), "post" do
    end
  end
end
