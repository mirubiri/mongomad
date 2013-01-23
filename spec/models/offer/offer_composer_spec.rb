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
    it { should have_field(:image).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(composer.valid?).to be_true }
    it 'Creates one offer' do
      expect { composer.save }.to change{ Offer.count}.by(1)
    end
  end

  describe '#save' do
    it 'Uploads an image' do
      composer.save
      File.exist?(File.new(composer.image.path)).should be_true
    end
  end
end
