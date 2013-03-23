require 'spec_helper'

describe Negotiation::Proposal::Composer do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:composer) { proposal.composer }

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Negotiation::Proposal) }
    it { should embed_many(:products).of_type(Negotiation::Proposal::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:nickname).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
    it { should accept_nested_attributes_for :products }
    it { should have_denormalized_fields :nickname,:image_name }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :nickname }
    it { should validate_presence_of :image_name }
  end

  describe 'Factories' do
    specify { expect(composer).to be_valid }

    it 'creates one negotiation' do
      expect { composer.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      composer.save
      expect(File.exist? composer.image.path).to eq true
    end
  end
end
