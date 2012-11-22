require 'spec_helper'

describe "userds/edit" do
  before(:each) do
    @userd = assign(:userd, stub_model(Userd))
  end

  it "renders the edit userd form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => userds_path(@userd), :method => "post" do
    end
  end
end
