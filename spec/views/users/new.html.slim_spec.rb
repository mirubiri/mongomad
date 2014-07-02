require 'rails_helper'

describe "users/new", :type => :view do
  before(:example) do
    assign(:user, stub_model(User).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", users_path, "post" do
    end
  end
end
