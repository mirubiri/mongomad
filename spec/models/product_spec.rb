require 'spec_helper'

describe Product do

  let(:product) { Fabricate.build(:product) }
  let(:item) { Item.find(product.id) }
  it 'should have one main image & two secondary images'

  # Relations
  it { should be_embedded_in :proposal }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :name,:description }
  it { should have_field(:quantity).of_type(Integer) }
  it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:_id).of_type(Moped::BSON::ObjectId) }

  # Validations
  it { should_not validate_presence_of :proposal }
  it { should validate_numericality_of(:quantity).to_allow(nil: false, only_integer: true, greater_than_or_equal_to: 0) }

  # Methods
  specify '.new' do
    expect(Product.new.id).to eq nil
  end

  describe '#item' do
    it 'return the item corresponding to product id' do
      expect(product.item).to eq item
    end
  end

  describe '#sell' do
    it 'sells this product calling item.sell with this product quantity' do
      expect(item).to_receive(:sell).with(product.quantity)
      product.sell
    end
  end

  describe '#available?' do
    it 'returns true if item has enought stock' do
      expect(product.available?).to eq true
    end
    it 'returns false if item has not enought stock' do
      product.quantity=100
      expect(product.available?).to eq false
    end
  end

  # Factories
  specify { expect(Fabricate.build(:product)).to be_valid }
end
