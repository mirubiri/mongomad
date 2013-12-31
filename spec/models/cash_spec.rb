require 'spec_helper'

describe Cash do
  # Variables
  let(:cash) { Fabricate.build(:cash) }

  # Relations
  specify { Cash.should < Good }

  # Attributes
  it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:money).of_type(Money) }

  # Validations
  it { should validate_presence_of :owner_id }
  it { should validate_presence_of :money }

  # Fabricator
  specify { expect(Fabricate.build(:cash)).to be_valid }
end