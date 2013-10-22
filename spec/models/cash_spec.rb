require 'spec_helper'

describe Cash do
  specify { Cash.should < Good }
  let(:cash) { Fabricate.build(:cash) }

  # Relations
  it { should be_embedded_in :proposal}

  # Validations
  it { should validate_presence_of :_money }
  it { should validate_presence_of :owner_id }

  # Fields
  it { should have_field(:_money).of_type(Money) }
  it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }

  # Fabricator
  specify { expect(Fabricate.build(:cash)).to be_valid }
end