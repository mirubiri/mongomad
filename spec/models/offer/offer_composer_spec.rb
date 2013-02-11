require 'spec_helper'

describe Offer::Composer do
  let(:composer) do
    composer=Fabricate.build(:offer).composer
  end

  describe 'Relations' do
    it { should be_embedded_in :offer }
    it { should embed_many(:products).of_type(Offer::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(composer.valid?).to be_true, "Is not valid because #{composer.errors}" }

    it 'Creates one offer' do
      expect { composer.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'on save' do
    it 'has an image' do
      composer.save
      File.exist?(File.new(composer.image.path)).should be_true
    end
  end

  describe '#self_update' do
    it 'calls update_user_data' do
       # Use relationship.target to access to the wrapped object
      composer.target.should_receive(:update_user_data)
      composer.self_update
    end

    it 'calls update_products' do
      composer.target.should_receive(:update_products)
      composer.self_update
    end

    it 'updates composer name with the current user composer name' do
      composer.offer.user_composer.profile.stub(:name).and_return('updated')
      composer.self_update
      composer.name.should eq 'updated'
    end

    it 'updates composer image_name with the current user composer image_name' do
      composer.offer.user_composer.profile.stub(:image_name).and_return('updated.png')
      composer.self_update
      composer.image_name.should eq 'updated.png'
    end
  end

  #TODO: TODAS ESTAS FUNCIONES NO DEBERIAN SER PRIVADAS Y NO TESTEARSE?
end