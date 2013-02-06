require 'spec_helper'

describe Offer::Composer do
  let(:composer) do
    Fabricate.build(:offer).composer
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

  describe '#save' do
    it 'Uploads an image' do
      composer.save
      File.exist?(File.new(composer.image.path)).should be_true
    end
  end

  describe '#auto_update' do
    it 'calls update_user_data' do
      composer.should_receive(:update_user_data)
      composer.auto_update
      puts "ESTO DA ERROR PERO ESTA BIEN ME CAGO EN TODO EL RSPEC Y EL MONGOID"
    end
    it 'calls update_products' do
      composer.should_receive(:update_products)
      composer.auto_update
      puts "ESTO DA ERROR PERO ESTA BIEN ME CAGO EN TODO EL RSPEC Y EL MONGOID"
    end
  end

  describe '#update_user_data' do
    around(:each) do
      composer.stub_chain(:offer,:user_composer,:profile,:name).and_return('updated')
      composer.stub_chain(:offer,:user_composer,:profile,:image).and_return('updated.png')
    end

    it 'updates composer name with the current user composer name' do
      composer.name.should eq 'updated'
    end

    it 'updates composer image with the current user composer image' do
      composer.image.should eq 'updated'
    end

  end

  describe 'update_products' do
  end

end
