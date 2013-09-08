require 'spec_helper'

describe Item do
  let(:item) { Fabricate.build(:item) }
  it 'should have one main image & two secondary images'

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
    specify { expect(item.pick(1).owner).to eq item.user.id }
  end

  describe '#sell(quantity)' do
    it 'removes the given quantity of items from the stock'
    it 'saves the change'
  end

  describe '#supply(quantity)' do
    it 're-stock this item with the given quantity'
    it 'saves the change'
  end
end
