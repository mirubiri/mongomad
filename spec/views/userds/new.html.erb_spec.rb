require 'spec_helper'

describe "userds/new" do
  before(:each) do
    assign(:userd, stub_model(Userd).as_new_record)
  end

  it "renders new userd form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => userds_path, :method => "post" do
    end
  end
end
