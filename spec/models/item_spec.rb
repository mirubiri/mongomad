require 'spec_helper'

describe Item do
  # Variables
  let(:item) { Fabricate.build(:item) }

  # Modules
  it { should include_module Attachment::Images }

  # Relations
  it { should belong_to :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :name, :description }

  # Validations

  # Methods
  describe '#to_product' do
    specify { expect(item.to_product.id).to eq item.id }
    specify { expect(item.to_product.user_id).to eq item.user_id }

    it 'returns a Product filled with item data' do
      expect(Product).to receive(:new).with(name:item.name, description:item.description, user_id:item.user_id, images:item.images)
      item.to_product
    end
  end

  describe '#withdraw' do
  end

  describe '#sell' do
  end

  describe '#hide' do
  end

  # Factories
  specify { expect(Fabricate.build(:item)).to be_valid }
end
