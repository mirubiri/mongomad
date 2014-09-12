require 'rails_helper'

describe NegotiationConfirmer do
  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:confirmer_id) { negotiation.composer.id }
  let(:negotiation_confirmer) { NegotiationConfirmer.new(negotiation) }
  let!(:deal_maker) { DealMaker.new(negotiation) }

  describe '#confirm(user_id)' do
    context 'given user_id can confirm' do
      before(:example) do
        allow(negotiation).to receive(:can_confirm?) { true }
      end

      it 'set given user_id as confirmer' do
        negotiation_confirmer.confirm(confirmer_id)
        expect(negotiation.confirmer).to eq confirmer_id
      end

      it 'calls DealMaker#make_deal with negotiation' do
        allow(DealMaker).to receive(:new).with(negotiation) { deal_maker }
        expect(deal_maker).to receive(:make_deal)
        negotiation_confirmer.confirm(confirmer_id)
      end

      it 'returns true' do
        result=negotiation_confirmer.confirm(confirmer_id)
        expect(result).to eq true
      end
    end

    context 'given_user_id cannot confirm' do
      before(:example) do
        allow(negotiation).to receive(:can_confirm?) { false }
      end

      it 'does not set given user_id as confirmer' do
        expect { negotiation_confirmer.confirm(confirmer_id) }.not_to change { negotiation.confirmer }
      end

      it 'does not call DealMaker with negotiation' do
        expect(deal_maker).not_to receive(:make_deal)
        negotiation_confirmer.confirm confirmer_id
      end

      it 'returns false' do
        result = negotiation_confirmer.confirm(confirmer_id)
        expect(result).to eq false
      end
    end

  end
end