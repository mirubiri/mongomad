require 'spec_helper'

describe Negotiation::Proposal::Receiver::Product do
  let(:product) do
    Fabricate.build(:negotiation).proposals.last.receiver.products.last
  end

  describe 'Relations' do
    it { should be_embedded_in(:receiver).of_type(Negotiation::Proposal::Receiver) }
  end

  describe 'Attributes' do
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:quantity).of_type(Integer).with_default_value_of(1) }
    it { should have_field(:image).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :thing_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :image }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(product.valid?).to be_true }
    it 'Creates one negotiation' do
      expect { product.save }.to change{ Negotiation.count}.by(1)
    end
    it 'Creates one offer' do
      expect { product.save }.to change{ Offer.count}.by(1)
    end
    it 'Creates two users' do
      expect { product.save }.to change{ User.count }.by(2)
    end
  end

  describe '#save' do
    it 'Uploads an image' do
      product.save
      File.exist?(File.new(product.image.path)).should be_true
    end
  end
end
