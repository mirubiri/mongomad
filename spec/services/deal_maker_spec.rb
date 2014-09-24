require 'rails_helper'

describe DealMaker do
  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:deal_maker) { DealMaker.new(negotiation) }
  
  describe '#make_deal(negotiation)' do
    context 'Negotiation is confirmed' do
      before(:example) { allow(negotiation).to receive(:confirmer?) { true } }

      it 'makes a new deal with the given negotiation state' do
        deal=deal_maker.make_deal

        expect(deal).to have_attributes(
          user_ids:negotiation.user_ids,
          proposals: negotiation.proposals,
          messages: negotiation.messages
          )
      end

      it 'destroys the negotiation' do
        deal_maker.make_deal
        expect(negotiation).to be_destroyed
      end
    end

    context 'Negotiation is not confirmed' do
      before(:example) { allow(negotiation).to receive(:confirmer?) { false } }
      
      it 'returns false' do
        expect(deal_maker.make_deal).to eq false
      end

      it 'does not make a new deal' do
        expect{deal_maker.make_deal}.not_to change{ Deal.count }
      end

      xit 'saves the new deal'

      it 'does not destroy the negotiation' do
        deal_maker.make_deal
        expect(negotiation).not_to be_destroyed
      end
    end
  end
end
