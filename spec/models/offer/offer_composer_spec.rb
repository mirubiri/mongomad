require 'spec_helper'

describe Offer::Composer do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:composer) { offer.composer }
  #let(:products_params) { params_for_offer(offer)[:composer_things] }
  #let(:thing) { user_composer.things.last }

  describe 'Relations' do
    it { should be_embedded_in :offer }
    it { should embed_many(:products).of_type(Offer::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
    it { should accept_nested_attributes_for(:products) }
    it { should have_denormalized_fields(:name, :image_name).from('offer.user_composer.profile') }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image_name }
  end

  describe 'Factories' do
    specify { expect(composer).to be_valid }

    it 'creates one offer' do
      expect { composer.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'after_save' do
    it 'has an image' do
      composer.save
      expect(File.exist? composer.image.path).to eq true
    end
  end
end
