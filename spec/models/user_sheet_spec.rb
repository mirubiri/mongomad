require 'spec_helper'

describe UserSheet do
  it 'should have an user photo'
  it 'should have a location reference'

  # Relations
  it { should be_embedded_in :user_sheet_container }

  # Attributes
  it { should have_fields :nick,:first_name,:last_name }
  it { should have_field(:_id).of_type(Moped::BSON::ObjectId).with_default_value_of(nil) }

  # Validations
  it { should validate_presence_of :nick }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :_id }

  # Methods
  specify '.new' do
    expect(UserSheet.new.id).to eq nil
  end

  # Factories
  specify { expect(Fabricate.build(:user_sheet)).to be_valid }
end
