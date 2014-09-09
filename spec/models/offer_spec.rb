require 'rails_helper'

describe Offer do

  let(:offer) { Fabricate.build(:offer) }

  specify { expect(Offer).to be < Proposable }

  # Relations

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :message }
  it { is_expected.to have_field :negotiation_id }

  # Methods

  describe '#negotiable?' do
    it 'calls #negotiating and negates the result' do
      expect(offer.negotiable?).to eq !offer.negotiating?
    end
  end

  describe '#negotiating?' do
    it 'returns false if the offer is not saved' do
      expect(offer.negotiating?).to eq false
    end

    it 'returns false if the offer is saved and is not being negotiated' do
      allow(offer).to receive(:persisted?) { true }
      expect(offer.negotiating?).to eq false
    end

    it 'returns true if the offer is saved and is being negotiated' do
      allow(offer).to receive(:persisted?) { true }
      offer.negotiation_id=1
      expect(offer.negotiating?).to eq true
    end
  end

  describe '#negotiate' do
    let(:starter) { double("NegotiationStarter",start:'start') }
    before(:example) { allow(NegotiationStarter).to receive(:new).with(offer) { starter } }
    
    it 'calls NegotiationStarter.new with self' do
      expect(NegotiationStarter).to receive(:new) { starter }
      offer.negotiate
    end

    it 'calls NegotiationStarter#start' do
      expect(starter).to receive(:start)
      offer.negotiate
    end

    it 'returns NegotiationStarter#start result' do
      expect(offer.negotiate).to eq starter.start
    end
  end
end
