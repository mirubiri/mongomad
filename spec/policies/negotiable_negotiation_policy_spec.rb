require 'rails_helper'

describe NegotiableNegotiationPolicy do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { offer.negotiate }
  let(:policy) { NegotiableNegotiationPolicy.new(negotiation) }

  describe '#negotiable?' do
    it 'is false when a user has left the negotiation' do
      negotiation.user_ids.pop
      expect(policy.negotiable?).to eq false
    end

    context 'both users are in the negotiation' do
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
end