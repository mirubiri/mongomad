require 'spec_helper'

describe Cash do
  # Variables
  specify { Cash.should < Good }

  # Relations
  let(:cash) { Fabricate.build(:cash) }
  it { should be_embedded_in :proposal}

  # Attributes
  it { should have_field(:_money).of_type(Money) }
  it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }

  # Validations
  it { should validate_presence_of :_money }
  it { should validate_presence_of :owner_id }

  # Fabricator
  specify { expect(Fabricate.build(:cash)).to be_valid }
end