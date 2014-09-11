require 'rails_helper'

describe NegotiationCourse do
  let(:negotiation) { Fabricate(:negotiation,cash: :composer) }
  let(:ncourse) { NegotiationCourse.new(negotiation) }
  let(:composer_id) { negotiation.composer.id }
  let(:receiver_id) { negotiation.receiver.id }
  let(:signer_id) { receiver_id }
  let(:non_signer_id) { composer_id }

  describe '#sign' do
    context 'given user can sign' do
      it 'returns true' do
        expect(ncourse.sign(signer_id)).to eq true
      end

      it 'signs the negotiation by the given user' do
        ncourse.sign(signer_id)
        expect(negotiation.signer).to eq signer_id
      end
    end
    
    context 'given user cannot sign' do
      it 'returns false' do
        expect(ncourse.sign(non_signer_id)).to eq false
      end

      it 'does not sign the negotiation by the given user' do
        ncourse.sign(non_signer_id)
        expect(negotiation.signer).to eq nil
      end
    end
  end

  describe '#confirm' do
    context 'given user can confirm' do
      it 'calls DealMaker with negotiation' do
      end
    end

    context 'given user cannot confirm' do
      it 'returns false' do
      end

      it 'doesnt call DealMaker with negotiation' do
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
    xit 'returns false if not signed' do
    end

    xit 'returns false if signed and given user_id signed' do
    end

    xit 'returns false if given user_id is not a participant' do
    end

    context 'signed and given user_id not signed' do
      xit 'creates a new deal' do
      end

      xit 'destroys the negotiation' do
      end
    end

  end
end