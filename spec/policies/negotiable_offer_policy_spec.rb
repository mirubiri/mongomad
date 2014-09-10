require 'rails_helper'

describe NegotiableOfferPolicy do
  let(:offer) { Fabricate.build :offer }
  let(:policy) { NegotiableOfferPolicy.new(offer) }

  describe '#negotiable?' do
    it 'is false when offer is not saved' do
      expect(policy.negotiable?).to eq false
    end

    it 'is true when offer is saved and is not being negotiated' do
      allow(offer).to receive(:persisted?) { true }
      expect(policy.negotiable?).to eq true
    end

    it 'is false when offer is saved and is being negotiated' do
      allow(offer).to receive(:persisted?) { true }
      offer.negotiation_id=1
      expect(policy.negotiable?).to eq false
    end
  end
end