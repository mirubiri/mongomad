require 'spec_helper'

describe Product do

  let(:item) { Fabricate(:item) }
  let(:product) { Fabricate.build(:product,item:item) }

  it 'should have one main image & two secondary images'

  # Relations
  it { should_not be_embedded_in :proposal }
  specify { Product.should < Asset }

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
    it 'calls to product.item' do
      expect(product).to receive(:item).and_call_original
      product.sell
    end

    it 'calls to item.sell with product.quantity' do
      expect_any_instance_of(Item).to receive(:sell).with(product.quantity)
      product.sell
    end
  end

  describe '#available?' do
    it 'calls to product.item' do
      expect(product).to receive(:item).and_call_original
      product.available?
    end

    it 'calls to item.available? with product.quantity' do
      expect_any_instance_of(Item).to receive(:available?).with(product.quantity)
      product.available?
    end
  end

  # Factories
  specify { expect(Fabricate.build(:product)).to be_valid }
end
