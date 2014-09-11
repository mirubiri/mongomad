require 'rails_helper'

describe NegotiationLifeCycleManager do
  let(:negotiation) { Fabricate(:negotiation,cash: :composer) }
  let(:nlcmanager) { NegotiationLifeCycleManager.new(negotiation) }
  let!(:deal_maker) { DealMaker.new(negotiation) }
  let(:composer_id) { negotiation.composer.id }
  let(:receiver_id) { negotiation.receiver.id }
  let(:signer_id) { receiver_id }
  let(:non_signer_id) { composer_id }
  let(:confirmer_id) { composer_id }
  let(:non_confirmer_id) { receiver_id }

  before(:example) do
    allow(DealMaker).to receive(:new) { deal_maker }
  end

  describe '#sign' do
    context 'given user can sign' do
      it 'returns true' do
        expect(nlcmanager.sign(signer_id)).to eq true
      end

      it 'signs the negotiation by the given user' do
        nlcmanager.sign(signer_id)
        expect(negotiation.signer).to eq signer_id
      end
    end
    
    context 'given user cannot sign' do
      it 'returns false' do
        expect(nlcmanager.sign(non_signer_id)).to eq false
      end

      it 'does not sign the negotiation by the given user' do
        nlcmanager.sign(non_signer_id)
        expect(negotiation.signer).to eq nil
      end
    end
  end

  describe '#confirm' do
    context 'given user can confirm' do
      before(:each) do
        allow(negotiation).to receive(:can_confirm?).with(confirmer_id) { true }
      end
      
      it 'calls DealMaker#make_deal with negotiation' do
        expect(DealMaker).to receive(:new).with negotiation
        expect(deal_maker).to receive(:make_deal)
        nlcmanager.confirm(confirmer_id)
      end
    end

    context 'given user cannot confirm' do
      it 'returns false' do
        expect(nlcmanager.confirm non_confirmer_id).to eq false
      end

      it 'doesnt call DealMaker with negotiation' do
        expect(deal_maker).not_to receive(:make_deal)
        nlcmanager.confirm non_confirmer_id
      end
    end
  end

  describe '#leave' do
    context 'both users in' do
      it 'removes the given user from the negotiation' do
        nlcmanager.leave(composer_id)
        expect(negotiation.user_ids).not_to include composer_id
      end

      it 'makes started offer negotiable again' do
        nlcmanager.leave(composer_id)
        offer=Offer.find(negotiation.offer_id)
        expect(offer.negotiation_id).to eq nil
      end
    end

    context 'one user in' do
      before(:example) { negotiation.leave(composer_id) }

      it 'destroys the negotiation' do
        nlcmanager.leave(receiver_id)
        expect(negotiation).to be_destroyed
      end
    end

    context 'given user is not participating' do
      it 'returns false' do
        expect(nlcmanager.leave('non_participant')).to eq false
      end
    end
  end
end