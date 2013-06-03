require 'spec_helper'

describe Negotiation do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }

  describe 'Relations' do
    it { should have_and_belong_to_many(:negotiators).of_type(User) }
    it { should embed_one(:conversation).of_type(Negotiation::Conversation) }
    it { should embed_many(:proposals).of_type(Negotiation::Proposal) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should accept_nested_attributes_for :conversation }
    it { should accept_nested_attributes_for :proposals }
  end

  describe 'Validations' do
    xit { should_not validate_presence_of :negotiators }
    it { should validate_presence_of :conversation }
    it { should validate_presence_of :proposals }
  end

  describe 'Factories' do
    specify { expect(negotiation).to be_valid }
    specify { expect(negotiation.save).to eq true }

    it 'creates one offer' do
      expect { negotiation.save }.to change{ Offer.count }.by(1)
    end

    it 'creates two different users' do
      expect { negotiation.save }.to change{ User.count }.by(2)
    end
  end

  describe '#seal_deal' do
    context 'When negotiation is saved' do
      before { negotiation.save }

      let(:deal) { negotiation.seal_deal }

      it 'returns a saved deal' do
        expect(deal).to be_persisted
      end

      it 'add the deal to composer in negotiation' do
        expect(deal).to eq proposal.user_composer.deals.first
      end

      it 'add the deal to receiver in negotiation' do
        expect(deal).to eq proposal.user_composer.deals.first
      end

      it 'returns a deal whose conversation has no messages' do
        expect(deal.conversation.messages).to have(0).messages
      end

      it 'returns a deal whose agreement has the values from original negotiation' do
        expect(deal.agreement).to be_like negotiation
      end
    end

    context 'When negotiation is not saved' do
      it 'returns nil' do
        expect(negotiation.seal_deal).to eq nil
      end
    end
  end
end
