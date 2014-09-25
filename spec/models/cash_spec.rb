require 'rails_helper'

describe Cash do
  let(:cash) { Fabricate.build(:cash) }

  # Relations
  specify { expect(Cash).to be < Good }

  # Attributes
  it { is_expected.to have_field(:amount) }

  # Methods

  describe '#to_product' do
    it 'returns self' do
      expect(cash.to_product).to eq cash
    end
  end
end
