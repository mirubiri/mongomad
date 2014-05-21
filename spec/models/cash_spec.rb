require 'spec_helper'

describe Cash do
  # Relations
  specify { Cash.should < Good }

  # Attributes
  it { should have_field(:amount) }

  # Validations

  # Factories
  specify { expect(Fabricate.build(:cash)).to be_valid }
end
