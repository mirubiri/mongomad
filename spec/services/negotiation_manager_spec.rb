require 'rails_helper'

describe NegotiationManager do
  let(:manager) { NegotiationManager.new }
  let(:offer) { Fabricate.build(:offer) }

  describe '#start_negotiation' do
    
    context 'given a negotiable offer' do
      before(:example) { allow(offer).to receive(:negotiable?) { true } }
      
      it 'creates a new negotiation with the offer contents' do
        expect(manager.start_negotiation(offer)).to have_attributes(user_sheets: offer.user_sheets,
                        proposals: [offer.proposal])
      end
    end

    context 'given a non negotiable offer' do
      before(:example) { allow(offer).to receive(:negotiable?) { false } }
        it 'returns false' do
          expect(manager.start_negotiation(offer)).to eq false
        end

        it 'do not start any new negotiation' do
          expect{manager.start_negotiation(offer)}.to_not change{Negotiation.count}
        end
    end
  end
end