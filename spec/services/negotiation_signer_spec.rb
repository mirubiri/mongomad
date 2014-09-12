require 'rails_helper'

describe NegotiationSigner do
  let(:negotiation) { Fabricate.build(:negotiation,cash: :composer) }
  let(:negotiation_signer) { NegotiationSigner.new(negotiation) }
  let(:signer_id) { negotiation.receiver.id }

describe '#sign' do
  context 'given user can sign' do
    before do
      allow(negotiation).to receive(:can_sign?) { true }
    end

    it 'returns true' do
      expect(negotiation_signer.sign(signer_id)).to eq true
    end

    it 'signs the negotiation by the given user' do
      negotiation_signer.sign(signer_id)
      expect(negotiation.signer).to eq signer_id
    end
  end
  
  context 'given user cannot sign' do
    before do
      allow(negotiation).to receive(:can_sign?) { false }
    end

    it 'returns false' do
      expect(negotiation_signer.sign(signer_id)).to eq false
    end

    it 'does not sign the negotiation by the given user' do
      negotiation_signer.sign(signer_id)
      expect(negotiation.signer).to eq nil
    end
  end
end
  
end