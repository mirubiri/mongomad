require 'spec_helper'

describe Item do
  let(:item) { Fabricate.build(:item) }
  it 'should have one main image & two secondary images'

  # Relations
  it { should be_embedded_in :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :name, :description }
  it { should have_field(:stock).of_type(Integer) }

  # Validations
  it { should validate_presence_of :stock }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_numericality_of(:stock).to_allow(nil: false, only_integer: true, greater_than_or_equal_to: 0) }

  # Factories
  specify { expect(Fabricate.build(:item)).to be_valid }

  # Methods
  describe '#as_product(quantity)' do

    it 'returns a Product filled with item name, description and given quantity' do
      expect(Product).to receive(:new).with(name:item.name,description:item.description,quantity:1)
      item.as_product(quantity:1)
      pending 'it expect to receive also item image urls when implemented'
    end

    specify { expect(item.as_product(quantity:1).id).to eq item.id }
    specify { expect(item.as_product(quantity:1).owner).to eq item.user.id }
  end
end
