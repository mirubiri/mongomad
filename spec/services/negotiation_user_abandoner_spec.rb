require 'rails_helper'

describe NegotiationUserAbandoner do
  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:negotiation_user_abandoner) { NegotiationUserAbandoner.new(negotiation) }
  let(:user_id) { negotiation.composer.id }

  shared_examples 'non participant user' do
    context 'given user is not participating in the negotiation' do
      before(:example) { allow(negotiation).to receive(:participant?) { false } }
    
      it 'returns false' do
        expect(negotiation_user_abandoner.abandon('non_participant')).to eq false
      end

      it 'does not call negotiation.destroy' do
        expect(negotiation).not_to receive(:destroy)
      end
    end
  end

  describe '#abandon(user_id)' do
    context 'negotiation is not abandoned' do
      before(:example) do
        allow(negotiation).to receive(:abandoned?) { false }
      end

      it 'removes the given user_id from the negotiation' do
        negotiation_user_abandoner.abandon(user_id)
        expect(negotiation.user_ids).not_to include user_id
      end

      it 'does not call negotiation.destroy' do
        expect(negotiation).not_to receive(:destroy)
      end

      it 'returns true' do
        expect(negotiation_user_abandoner.abandon(user_id)).to eq true
      end

      include_examples 'non participant user'
    end

    context 'negotiation is abandoned' do
      before(:example) do
        allow(negotiation).to receive(:abandoned?) { true }
      end

      it 'destroys the negotiation' do
        expect(negotiation).to receive(:destroy)
        negotiation_user_abandoner.abandon(user_id)
      end

      include_examples 'non participant user'
    end
  end
end
