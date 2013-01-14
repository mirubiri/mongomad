require 'spec_helper'

describe Offer::Receiver::Product do
  let(:product) do
    Fabricate.build(:offer).receiver.products.last
  end

  describe 'Relations' do
    it { should be_embedded_in(:receiver).of_type(Offer::Receiver) }
    it { should embed_many(:images).of_type(Offer::Receiver::Product::Image) }
  end

  describe 'Attributes' do
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:quantity).of_type(Integer).with_default_value_of(1) }
    it { should have_field(:main_image).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :images }
    it { should validate_presence_of :thing_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :main_image }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(product.valid?).to be_true }
  end
end
