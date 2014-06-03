require 'spec_helper'

describe Cash, :type => :model do
  # Relations
  specify { expect(Cash).to be < Good }

  # Attributes
  it { is_expected.to have_field(:amount) }

  # Validations

  # Factories
  specify { expect(Fabricate.build(:cash)).to be_valid }
end
