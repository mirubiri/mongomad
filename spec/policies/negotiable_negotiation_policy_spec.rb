require 'rails_helper'

describe NegotiableNegotiationPolicy do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { offer.negotiate }
  let(:policy) { NegotiableNegotiationPolicy.new(negotiation) }

  describe '#negotiable?' do
      it 'is false when proposal is not negotiable' do
        allow(negotiation.proposal).to receive(:negotiable?) { false }
        expect(policy.negotiable?).to eq false
      end

      it 'is true if proposal is negotiable' do
        allow(negotiation.proposal).to receive(:negotiable?) { true }
        expect(policy.negotiable?).to eq true
      end
  end
end
