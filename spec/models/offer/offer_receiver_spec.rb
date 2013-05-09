require 'spec_helper'

describe Offer::Receiver do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:receiver) { offer.receiver }

  describe 'Includes' do
    xit 'include ImageManager::ImageHolder'
  end

  describe 'Relations' do
    it { should be_embedded_in :offer }
    it { should embed_many(:products).of_type(Offer::Receiver::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:nick).of_type(String) }
    it { should accept_nested_attributes_for :products }
    it { should have_denormalized_fields(:nick, :image_fingerprint).from('offer.user_receiver.profile') }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :offer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :nick }
  end

  describe 'Factories' do
    specify { expect(receiver).to be_valid }

    it 'creates one offer' do
      expect { receiver.save }.to change{ Offer.count }.by(1)
    end
  end
end
