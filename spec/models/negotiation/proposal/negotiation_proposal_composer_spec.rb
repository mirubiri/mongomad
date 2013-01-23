require 'spec_helper'

describe Negotiation::Proposal::Composer do
  let(:composer) do
    Fabricate.build(:negotiation).proposals.last.composer
  end

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Negotiation::Proposal) }
    it { should embed_many(:products).of_type(Negotiation::Proposal::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:image).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(composer.valid?).to be_true }
    it 'Creates one negotiation' do
      expect { composer.save }.to change{ Negotiation.count}.by(1)
    end
  end

  describe '#save' do
    it 'Uploads an image' do
      composer.save
      File.exist?(File.new(composer.image.path)).should be_true
    end
  end
end

