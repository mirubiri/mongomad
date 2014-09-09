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
    it 'is not negotiable when not saved' do
      expect(offer).not_to be_negotiable
    end

    it 'is not negotiable when not saved and negotiation_id set' do
      offer.negotiation_id=1
      expect(offer).not_to be_negotiable
    end

    it 'is not negotiable when saved and negotiation_id set' do
      offer.negotiation_id=1
      offer.save
      expect(offer).not_to be_negotiable
    end

    it 'is negotiable when saved and negotiation_id not set' do
      offer.save
      expect(offer).to be_negotiable
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
