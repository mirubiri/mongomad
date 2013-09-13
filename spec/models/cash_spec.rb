require 'spec_helper'

describe Cash do
  specify { Cash.should < Good }

  # Relations
  it { should be_embedded_in :proposal}

  # Validations

  it { should validate_presence_of :_money }
  it { should validate_presence_of :owner_id }

  # Fields
  it { should have_field(:_money).of_type(Money) }
  it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }

  # Methods
  specify '.new' do
    expect(Cash.new.id).to eq nil
  end
end
