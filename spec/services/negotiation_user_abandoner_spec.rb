require 'rails_helper'

describe NegotiationUserAbandoner do
  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:negotiation_user_abandoner) { NegotiationUserAbandoner.new(negotiation) }
  let(:user_id) { negotiation.composer.id }

  describe '#abandon(user_id)' do
    context 'negotiation is not abandoned' do
      before(:example) do
        allow(negotiation).to receive(:abandoned?) { false }
      end

      it 'removes the given user_id from the negotiation' do
        negotiation_user_abandoner.abandon(user_id)
        expect(negotiation.user_ids).not_to include user_id
      end

      it 'returns true' do
        expect(negotiation_user_abandoner.abandon(user_id)).to eq true
      end
    end

    context 'negotiation is abandoned' do
      before(:example) do
        allow(negotiation).to receive(:abandoned?) { true }
      end

      it 'destroys the negotiation' do
        negotiation_user_abandoner.abandon(user_id)
        expect(negotiation).to be_destroyed
      end
    end

    context 'given user is not participating' do
      before(:example) do
        allow(negotiation).to receive(:abandoned?) { false }
      end

      it 'returns false' do
        expect(negotiation_user_abandoner.abandon('non_participant')).to eq false
      end
    end
  end
end