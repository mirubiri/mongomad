require 'spec_helper'

describe Negotiation::Proposal do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:negotiation_composer) { negotiation.negotiators.find(proposal.user_composer_id) }
  let(:negotiation_receiver) { negotiation.negotiators.find(proposal.user_receiver_id) }
  # let(:proposals) { [ Fabricate(:offer_composer_money).start_negotiation.proposals.last,
  #   Fabricate(:offer_receiver_money).start_negotiation.proposals.last ] }
  #   let(:negotiator) { negotiation_composer}

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

  describe 'state_machine' do
    context 'When composer offers money' do
      context 'and proposal is in :nil state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :unsigned state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :composer_signed state' do
         # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :receiver_signed state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :composer_confirmed state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :receiver_confirmed state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :composer_canceled state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :receiver_canceled state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
    end
    context 'When receiver offers money' do
      context 'and proposal is in :nil state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :unsigned state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :composer_signed state' do
         # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :receiver_signed state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :composer_confirmed state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :receiver_confirmed state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :composer_canceled state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :receiver_canceled state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
    end
    context 'When there is no money' do
      context 'and proposal is in :nil state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :unsigned state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :composer_signed state' do
         # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :receiver_signed state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :composer_confirmed state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :receiver_confirmed state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :composer_canceled state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
      context 'and proposal is in :receiver_canceled state' do
        # before
        xit 'change from :nil to : on :unsign event'
        xit 'change from :nil to : on :sign_composer event'
        xit 'change from :nil to : on :sign_receiver event'
        xit 'change from :nil to : on :confirm_composer event'
        xit 'change from :nil to : on :confirm_receiver event'
        xit 'change from :nil to : on :cancel_composer event'
        xit 'change from :nil to : on :cancel_receiver event'
      end
    end
  end
end
