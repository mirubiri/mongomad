require 'rails_helper'

describe AuthorizedDealPolicy do
  let(:deal) { Fabricate.build(:deal) }
  let(:authorizer) { AuthorizedDealPolicy.new(deal) }
  let(:user_id) { deal.composer.id }

  describe '#authorized?(user_id)' do
    it 'returns true if user_id is a participant in the deal' do
      allow(deal).to receive(:participant?) { true }
      expect(authorizer.authorized? user_id).to eq true
    end

    it 'returns false if user_id is a participant in the deal' do
      allow(deal).to receive(:participant?) { false }
      expect(authorizer.authorized? user_id).to eq false
    end
  end
end
