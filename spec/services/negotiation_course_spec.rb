require 'rails_helper'

describe NegotiationCourse do
  let(:negotiation) { Fabricate(:offer).negotiate }
  let(:ncourse) { NegotiationCourse.new(negotiation) }
  let(:composer_id) { negotiation.composer.id }
  let(:receiver_id) { negotiation.receiver.id }

  describe '#sign' do

    it 'returns false if not negotiating' do
      allow(negotiation).to receive(:negotiating?) { false }
      expect(ncourse.sign(composer_id)).to eq false
    end

    it 'returns false if signed' do
      ncourse.sign(composer_id)
      allow(negotiation).to receive(:signer?) { true }
      expect(ncourse.sign(composer_id)).to eq false
    end

    it 'returns false if given user_id is not participating' do
      expect(ncourse.sign('non_participant')).to eq false
    end

    it 'returns false if given user has money' do
      negotiation=Fabricate.build(:negotiation,cash: :composer)
      expect(ncourse.sign(negotiation.composer.id)).to eq false
    end

    context 'given user has no money and not signed' do
      before(:example) { negotiation= Fabricate.build(:negotiation,cash: :composer)}
      it 'returns true' do
        expect(ncourse.sign(receiver_id)).to eq true
      end

      it 'signs the negotiation by the given user' do
        ncourse.sign(receiver_id)
        expect(negotiation.signer).to eq receiver_id
      end
    end
  end

  describe '#leave' do
    context 'both users in' do
      it 'removes the given user from the negotiation' do
        ncourse.leave(composer_id)
        expect(negotiation.user_ids).not_to include composer_id
      end

      it 'makes started offer negotiable again' do
        ncourse.leave(composer_id)
        offer=Offer.find(negotiation.offer_id)
        expect(offer.negotiation_id).to eq nil
      end
    end

    context 'one user in' do
      before(:example) { negotiation.leave(composer_id) }

      it 'destroys the negotiation' do
        ncourse.leave(receiver_id)
        expect(negotiation).to be_destroyed
      end
    end

    context 'given user is not participating' do
      it 'returns false' do
        expect(ncourse.leave('non_participant')).to eq false
      end
    end
  end

  describe '#confirm' do
    it 'returns false if not signed' do
    end

    it 'returns false if signed and given user_id signed' do
    end

    it 'returns false if given user_id is not a participant' do
    end

    context 'signed and given user_id not signed' do
      it 'creates a new deal' do
      end

      it 'destroys the negotiation' do
      end
    end

  end
end