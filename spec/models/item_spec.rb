require 'spec_helper'

describe Item do
  let(:item) { Fabricate.build(:item) }

  # Modules
  it { should include_module Attachment::Images }

  # Relations
  it { should belong_to :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :name, :description }
  it { should have_field(:stock).of_type(Integer) }

  # Validations
  it { should validate_presence_of :user }
  it { should validate_presence_of :stock }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_numericality_of(:stock).to_allow(nil: false, only_integer: true, greater_than_or_equal_to: 0) }

  # Factories
  specify { expect(Fabricate.build(:item)).to be_valid }

  # Methods
  describe '#pick(quantity)' do

    it 'returns a Product filled with item name, description and given quantity' do
      expect(Product).to receive(:new).with(name:item.name,description:item.description,quantity:1)
      item.pick(1)
      pending 'it expect to receive also item image urls when implemented'
    end

    specify { expect(item.pick(1).id).to eq item.id }
    specify { expect(item.pick(1).owner_id).to eq item.user.id }
  end

  describe '#sell(quantity)' do
    it 'removes the given quantity of items from the stock' do
      expect {item.sell(1)}.to change {item.stock}.by(-1)
    end
    it 'saves the change' do
      item.sell(1)
      expect(item).to be_persisted
    end

    context 'When given quantity is not available' do
      it 'returns false' do
        expect(item.sell(100)).to eq false
      end

      it 'does not change the stock attribute' do
        stock=item.stock
        item.sell(100)
        expect(item.stock).to eq stock
      end
    end
  end

  describe '#supply(quantity)' do
    it 're-stock this item with the given quantity' do
      expect {item.supply(1)}.to change {item.stock}.by(1)
    end
    it 'saves the change' do
      item.supply(1)
      expect(item).to be_persisted
    end
  end

  describe '#available?(quantity)' do
    it 'true if item has enough asked stock' do
      asked=item.stock-1
      expect(item.available?(asked)).to eq true
    end

    it 'false if item has not enough asked stock' do
      asked=item.stock+1
      expect(item.available?(asked)).to eq false
    end

    it 'false if stock is nil' do
      item.stock=nil
      expect(item.available?(1)).to eq false
    end

    it 'false if asked stock is 0' do
      expect(item.available?(0)).to eq false
    end
  end
end
