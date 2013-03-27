require 'spec_helper'

describe Offer::Receiver do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:receiver) { offer.receiver }

  describe 'Relations' do
    it { should be_embedded_in :offer }
    it { should embed_many(:products).of_type(Offer::Receiver::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:nickname).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
    it { should accept_nested_attributes_for :products }
    it { should have_denormalized_fields(:nickname, :image_name).from('offer.user_receiver.profile') }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :nickname }
    it { should validate_presence_of :image_name }
  end

  describe 'Factories' do
    specify { expect(receiver).to be_valid }

    it 'creates one offer' do
      expect { receiver.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'after_save' do
    it 'has an image' do
      receiver.save
      expect(File.exist? receiver.image.path).to eq true
    end
  end
end
