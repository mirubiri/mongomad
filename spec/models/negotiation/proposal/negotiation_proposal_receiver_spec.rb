require 'spec_helper'

describe Negotiation::Proposal::Receiver do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:receiver) { proposal.receiver }

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Negotiation::Proposal) }
    it { should embed_many(:products).of_type(Negotiation::Proposal::Receiver::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image_name }
  end

  describe 'Factories' do
    specify { expect(receiver.valid?).to eq true }

    it 'creates one negotiation' do
      expect { receiver.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      receiver.save
      File.exist?(File.new(receiver.image.path)).should eq true
    end
  end
end
