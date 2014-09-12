require 'rails_helper'

describe Offer do

  let(:offer) { Fabricate.build(:offer) }
  let!(:policy) { NegotiableOfferPolicy.new(offer) }
  before(:example) { allow(NegotiableOfferPolicy).to receive(:new) {policy} }

  it { is_expected.to include_module Proposable }

  # Relations

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :message }
  it { is_expected.to have_field :negotiation_id }

  # Methods

  describe '#negotiable?' do
    it 'calls NegotiableOfferPolicy#negotiable?' do
      expect(policy).to receive(:negotiable?)
      offer.negotiable?
    end
  end

  describe '#negotiating?' do
    it 'returns true if is beign negotiated' do
      offer.negotiation_id='some'
      expect(offer.negotiating?).to eq true
    end

    it 'returns false if is not beign negotiated' do
      offer.negotiation_id=nil
      expect(offer.negotiating?).to eq false
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
