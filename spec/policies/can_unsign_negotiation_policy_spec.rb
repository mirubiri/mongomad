require 'rails_helper'

describe CanUnsignNegotiationPolicy do
  let(:negotiation) { Fabricate.build(:negotiation,cash: :receiver) }
  let(:signer_id) { negotiation.composer.id }
  let(:not_signer_id) { negotiation.receiver.id }
  let(:policy) { CanUnsignNegotiationPolicy.new(negotiation) }

  describe '#can_unsign?(user_id)' do
  	before(:example) { negotiation.sign(signer_id) }

    it 'returns false if negotiation is not negotiable' do
      allow(negotiation).to receive(:negotiable?) { false }
      expect(policy.can_unsign? signer_id).to eq false
    end

    it 'returns true if negotiation was signed by the given user_id' do
      expect(policy.can_unsign? signer_id).to eq true
    end

    it 'returns false if user_id did not signed the negotiation' do
      expect(policy.can_unsign? not_signer_id).to eq false
    end

    it 'returns false if given user is unknown' do
    	expect(policy.can_unsign? 'unknown').to eq false
    end
  end
end