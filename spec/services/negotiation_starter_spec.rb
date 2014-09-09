require 'rails_helper'

describe NegotiationStarter do
  let(:offer) { Fabricate.build(:offer) }

  let(:starter) { NegotiationStarter.new(offer) }

  describe '.new' do
    it 'needs to be initialized with an offer' do
      expect{NegotiationStarter.new}.to raise_error
    end
  end

  describe '#start' do
    context 'offer is negotiable' do
      before(:example) { allow(offer).to receive(:negotiable?) { true } }

      it 'returns a saved negotiation with the offer\'s data' do
        expect(starter.start).to be_persisted.and have_attributes \
          proposal:offer.proposal,
          user_sheets:offer.user_sheets,
          offer_id:offer.id
      end

    end

    context 'offer is not negotiable' do
      before(:example) { allow(offer).to receive(:negotiable?) { false } }
      
      it 'returns false' do
        expect(starter.start).to eq false
      end

      it 'does not create a new negotiation' do
        expect{starter.start}.not_to change{Negotiation.count}
      end
    end
  end

  describe '#offer' do
    it 'returns the offer used to initialize NegotiationStarter' do
      expect(starter.offer).to eq offer
    end
  end

  describe '#negotiation' do
    context 'start was called' do
      it 'returns the created negotiation' do
        allow(offer).to receive(:negotiable?) { true }
        negotiation=starter.start
        expect(starter.negotiation).to eq negotiation
      end
    end

    context 'start was not called' do
      it 'returns nil' do
        expect(starter.negotiation).to eq nil
      end
    end

    context 'start returned false' do
      it 'returns nil' do
        allow(starter).to receive(:start) { false }
        starter.start
        expect(starter.negotiation).to eq nil
      end
    end
  end

end