require 'spec_helper'

describe Negotiation do
  let(:offer) do
    Fabricate(:offer)
  end

  let(:negotiation) do
    Fabricate.build(:negotiation, offer:offer)
  end

  describe 'Relations' do
    it { should embed_many(:proposals).of_type(Negotiation::Proposal) }
    it { should embed_many(:messages).of_type(Negotiation::Message) }
    it { should have_and_belong_to_many(:users) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:token_user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:token_state).of_type(Symbol) }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
    it { should validate_presence_of :users }
    it { should validate_presence_of :token_user_id }
    it { should validate_presence_of :token_state }
    it { should validate_inclusion_of(:token_state).to_allow([:propose, :accept]) }
  end

  describe 'Factories' do
    specify { expect(negotiation.valid?).to be_true, "Is not valid because #{negotiation.errors}" }
    specify { expect(negotiation.save).to be_true }

    it 'Creates one offer' do
      expect { negotiation.save }.to change{ Offer.count }.by(1)
    end

    it 'Creates two different users' do
      expect { negotiation.save }.to change{ User.count }.by(2)
    end
  end
  
  
  let(:new_negotiation) { Negotiation.open(offer).publish }

  describe '.start_with(offer)' do
    it 'generates a valid negotiation given an offer' do
      Negotiation.start_with(offer).should be_valid
    end

    it 'throws an exception given an invalid offer' do
      offer.should_receive(:valid?).and_return(:false)
      Negotiation.start_with(offer).should raise_error
      pending 'Choose wich exception to throw'
    end

    specify { new_negotiation.users.should include(offer.user_composer,offer.user_receiver) }
  end

  describe '#kick(user)' do
    xit 'Kicks the given user from the negotiation'
  end

  describe '#do_new_proposal(hash)' do
    xit 'Adds to negotiation a new proposal from the given hash'
  end

  describe '#post_message(hash)' do
    xit 'Adds to negotiation a new message from the given hash'
  end

  describe '#can_propose?(user)' do
    xit 'Returns if the given user can propose a deal'
  end

  describe '#propose_deal(user)' do
    xit 'Updates token to set the given user has proposed a deal'
  end

  describe '#can_close?(user)' do
    xit 'Returns if the given user can close a deal'
  end

  describe '#make_deal' do
    xit 'Returns a deal from the current negotiation'
  end

  describe '#self_update ' do
    xit 'Updates itself'
  end
end
