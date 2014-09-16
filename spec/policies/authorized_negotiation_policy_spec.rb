require 'rails_helper'

describe AuthorizedNegotiationPolicy do
  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:authorizer) { AuthorizedNegotiationPolicy.new(negotiation) }
  let(:authorized_id) { negotiation.composer.id }
  let(:unauthorized_id) { 'unauthorized'}

  describe '#authorized?' do
    it 'returns false if negotiation is not negotiable' do
      allow(negotiation).to receive(:negotiable?) { false }
      expect(authorizer.authorized? authorized_id).to eq false
    end
    it 'returns true if user_id is participating in the negotiation' do
    	expect(authorizer.authorized? authorized_id).to eq true
    end

    it 'returns false if user_id is not participating in the negotiation' do
    	expect(authorizer.authorized? unauthorized_id).to eq false
    end
  end
end