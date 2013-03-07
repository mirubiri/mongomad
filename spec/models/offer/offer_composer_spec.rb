require 'spec_helper'

describe Offer::Composer do
  let(:offer) { Fabricate.build(:offer) }
  let(:composer) { offer.composer }
  let(:composer_things_params) { params_for_offer(offer)[:composer_things] }

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
    it { should validate_presence_of :image_name }
  end

  describe 'Factories' do
    specify { expect(composer.valid?).to eq true }

    it 'creates one offer' do
      expect { composer.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      composer.save
      File.exist?(File.new(composer.image.path)).should eq true
    end
  end

=begin
  describe '#alter_contents(params)' do
    after { composer.alter_contents(composer_things_params) }

    it 'removes the current list of products' do
      composer.products.should_receive(:destroy)
    end

    it 'add the given list of products' do
      composer.target.should_receive(:add_products).with(composer_things_params)
    end

    it 'calls to self_update' do
      pending 'pensar si llamarlo o no'
    end
  end

  describe '#update_products' do
    xit 'update the information of all products'
  end

  describe '#add_products(params)' do
    it 'creates a product for each passed product_params' do
      product_list=composer.products.dup
      composer.products.destroy
      composer.add_products(product_list)
      composer.self_update
      expect(composer.products).to be_like product_list
    end

    xit 'add all products in a single operation'
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
=end
end
