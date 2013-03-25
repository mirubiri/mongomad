require 'spec_helper'

describe Offer::Receiver::Product do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:receiver) { offer.receiver }
  let(:product) { receiver.products.last }

  describe 'Relations' do
    it { should be_embedded_in(:receiver).of_type(Offer::Receiver) }
  end

  describe 'Attributes' do
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:quantity).of_type(Integer) }
    it { should have_field(:image_name).of_type(Object) }
    it { should have_denormalized_fields(:name, :description, :image_name).from('thing') }
  end

  describe 'Validations' do
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :thing_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :image_name }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(product).to be_valid }

    it 'creates one offer' do
      expect { product.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'after_save' do
    it 'has an image' do
      product.save
      expect(File.exist? product.image.path).to eq true
    end
  end

  describe '#thing' do
    subject { product.thing }

    it { should be_instance_of(User::Thing) }

    it 'returns thing which originated this product' do
      expect(subject.id).to eq product.thing_id
    end
  end
end
