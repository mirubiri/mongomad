require 'spec_helper'

describe Offer::Composer do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:composer) { offer.composer }

  describe 'Includes' do
    xit 'include ImageManager::ImageHolder'
  end

  describe 'Relations' do
    it { should be_embedded_in :offer }
    it { should embed_many(:products).of_type(Offer::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should accept_nested_attributes_for :products }
    it { should have_denormalized_fields(:image_fingerprint).from('offer.user_composer.profile') }
    it { should have_denormalized_fields(:name).from('offer.user_composer') }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :offer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
  end

  describe 'Factories' do
    specify { expect(composer).to be_valid }

    it 'creates one offer' do
      expect { composer.save }.to change{ Offer.count }.by(1)
    end
  end
end
