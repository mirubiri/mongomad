require 'spec_helper'

describe Cash do
  # Relations
  specify { Cash.should < Good }

  # Attributes
  it { should have_field(:money).of_type(Money) }

  # Validations
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :money }

  # Factories
  specify { expect(Fabricate.build(:cash)).to be_valid }
end
