require 'rails_helper'

describe CanConfirmNegotiationPolicy do

  let(:negotiation) { Fabricate.build(:negotiation,cash: :receiver) }
  let(:confirmer_id) { negotiation.composer.id }
  let(:signer_id) { negotiation.receiver.id }
  let(:policy) { CanConfirmNegotiationPolicy.new(negotiation) }

  describe '#can_confirm?(user_id)' do
    it 'returns false if negotiation is not signed' do
      expect(policy.can_confirm? confirmer_id).to eq false
    end

    it 'returns false if given user_id signed' do
      negotiation.signer=confirmer_id
      expect(policy.can_confirm? confirmer_id).to eq false
    end

    it 'returns false if given user_id is not authorized' do
      allow(negotiation).to receive(:authorized?) { false }
      expect(policy.can_confirm? 'unknown_user').to eq false
    end

    it 'returns false if proposal is not negotiable' do
      negotiation.signer=signer_id
      allow(negotiation).to receive(:negotiable?) { false }
      expect(policy.can_confirm? confirmer_id).to eq false
    end

    it 'returns true in any other case' do
      negotiation.signer=signer_id
      expect(policy.can_confirm? confirmer_id).to eq true
    end
  end
end
