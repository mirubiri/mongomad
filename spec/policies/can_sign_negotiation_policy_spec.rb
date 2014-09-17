require 'rails_helper'

describe CanSignNegotiationPolicy do
  
  let(:negotiation) { Fabricate.build(:negotiation,cash: :receiver) }
  let(:signer_id) { negotiation.composer.id }
  let(:non_signer_id) { negotiation.receiver.id }
  let(:policy) { CanSignNegotiationPolicy.new(negotiation) }

  describe '#can_sign?(user_id)' do
    it 'returns false if negotiation has a signer' do
      allow(negotiation).to receive(:signer?) { true }
      expect(policy.can_sign? signer_id).to eq false
    end

    it 'returns false if user_id is not authorized' do
      allow(negotiation).to receive(:authorized?) { false }
      expect(policy.can_sign? 'unknown_user').to eq false
    end

    it 'returns false if user_id has cash in the negotiation' do
      expect(policy.can_sign? non_signer_id).to eq false
    end

    it 'returns false if proposal is not negotiable' do
      allow(negotiation).to receive(:negotiable?) { false }
      expect(policy.can_sign? signer_id).to eq false
    end
    
    it 'returns true in any other case' do
      expect(policy.can_sign? signer_id).to eq true
    end
  end
end
