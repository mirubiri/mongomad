require 'spec_helper'

describe Negotiation::Proposal do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:negotiation_composer) { negotiation.negotiators.find(proposal.user_composer_id) }
  let(:negotiation_receiver) { negotiation.negotiators.find(proposal.user_receiver_id) }

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
    it { should embed_one(:composer).of_type(Negotiation::Proposal::Composer) }
    it { should embed_one(:receiver).of_type(Negotiation::Proposal::Receiver) }
    it { should embed_one(:money).of_type(Negotiation::Proposal::Money) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_composer_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:user_receiver_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:state).of_type(String) }
    it { should have_field(:confirmable_state).of_type(String) }
    it { should accept_nested_attributes_for :composer }
    it { should accept_nested_attributes_for :receiver }
    it { should accept_nested_attributes_for :money }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :negotiation }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :user_composer_id }
    it { should validate_presence_of :user_receiver_id }
    it { should_not validate_presence_of :state }
    it { should validate_presence_of :confirmable_state }
  end

  describe 'Factories' do
    specify { expect(proposal).to be_valid }

    it 'creates one negotiation' do
      expect { proposal.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe '#user_composer' do
    context 'When proposal has no negotiation assigned' do
      it 'returns nil' do
        proposal.negotiation = nil
        expect(proposal.user_composer).to eq nil
      end
    end

    context 'When proposal has a negotiation assigned' do
      it 'returns the user of the negotiation who made the proposal' do
        expect(proposal.user_composer).to eq negotiation_composer
      end
    end
  end

  describe '#user_receiver' do
    context 'When proposal has no negotiation assigned' do
      it 'returns nil' do
        proposal.negotiation = nil
        expect(proposal.user_receiver).to eq nil
      end
    end

    context 'When proposal has a negotiation assigned' do
      it 'returns the user of the negotiation who received the proposal' do
        expect(proposal.user_receiver).to eq negotiation_receiver
      end
    end
  end

  describe '#state' do
    before { proposal.save }

    it 'initial state is :unsigned when composer has money' do
      user = Fabricate(:user_with_things)
      offer = Fabricate(:offer, user_composer:user, money:Fabricate.build(:offer_money, user_id:user.id, quantity:'150'))
      expect(offer.start_negotiation.proposals.last.state).to eq 'unsigned'
    end

    it 'initial state is :composer_signed when composer has no money' do
      expect(proposal.state).to eq 'composer_signed'
    end

    context 'When proposal is in :unsigned state' do
      before do
        proposal.state = :unsigned
      end

      it 'change from :unsigned to :receiver_signed on :sign_receiver event' do
        proposal.sign_receiver
        expect(proposal.state).to eq 'receiver_signed'
      end

      it 'change from :unsigned to :composer_canceled on :cancel_composer event' do
        proposal.cancel_composer
        expect(proposal.state).to eq 'composer_canceled'
      end

      it 'change from :unsigned to :receiver_canceled on :cancel_receiver event' do
        proposal.cancel_receiver
        expect(proposal.state).to eq 'receiver_canceled'
      end
    end

    context 'When proposal is in :composer_signed state' do
      before do
        proposal.state = :composer_signed
      end

      it 'change from :composer_signed to :receiver_confirmed on :confirm_receiver event' do
        proposal.confirm_receiver
        expect(proposal.state).to eq 'receiver_confirmed'
      end

      it 'change from :composer_signed to :composer_canceled on :cancel_composer event' do
        proposal.cancel_composer
        expect(proposal.state).to eq 'composer_canceled'
      end

      it 'change from :composer_signed to :receiver_canceled on :cancel_receiver event' do
        proposal.cancel_receiver
        expect(proposal.state).to eq 'receiver_canceled'
      end
    end

    context 'When proposal is in :receiver_signed state' do
      before do
        proposal.state = :receiver_signed
      end

      it 'change from :receiver_signed to :composer_confirmed on :confirm_composer event' do
        proposal.confirm_composer
        expect(proposal.state).to eq 'composer_confirmed'
      end

      it 'change from :receiver_signed to :composer_canceled on :cancel_composer event' do
        proposal.cancel_composer
        expect(proposal.state).to eq 'composer_canceled'
      end

      it 'change from :receiver_signed to :receiver_canceled on :cancel_receiver event' do
        proposal.cancel_receiver
        expect(proposal.state).to eq 'receiver_canceled'
      end
    end
  end

  describe '#seal_deal' do
    context 'When negotiation is saved' do
      before { proposal.negotiation.save }

      let(:deal) { proposal.seal_deal }

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
        expect(proposal.seal_deal).to eq nil
      end
    end
  end
end
