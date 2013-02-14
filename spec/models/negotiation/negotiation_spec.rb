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
    it { should_not have_and_belong_to_many(:users) }
    it { should have_and_belong_to_many(:negotiators).of_type(User) }
    it { should embed_one(:token).of_type(Negotiation::Token) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should_not have_field(:token_user_id).of_type(Moped::BSON::ObjectId) }
    it { should_not have_field(:token_state).of_type(Symbol) }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
    it { should_not validate_presence_of :users }
    it { should validate_presence_of :negotiators }
    it { should_not validate_presence_of :token_user_id }
    it { should_not validate_presence_of :token_state }
    it { should_not validate_inclusion_of(:token_state).to_allow([:propose, :accept]) }
  end

  describe 'Factories' do
    specify { expect(negotiation.valid?).to be_true }
    specify { expect(negotiation.save).to be_true }

    it 'Creates one offer' do
      expect { negotiation.save }.to change{ Offer.count }.by(1)
    end

    it 'Creates two different users' do
      expect { negotiation.save }.to change{ User.count }.by(2)
    end
  end

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

  describe '#kick(negotiator)' do

    let(:leaving_negotiator) { negotiation.negotiators.first }

    context 'When negotiator is in negotiation' do
      it 'kicks a given negotiatior from the negotiation' do
        negotiation.kick(leaving_negotiator)
        negotiation.negotiators.should_not include(leaving_negotiator)
      end

      it 'removes the negotiation from the kicked negotiator' do
        negotiation.kick(leaving_negotiator)
        leaving_negotiator.reload
        leaving_negotiator.negotiations.should_not include(negotiation)
      end

      context 'when kicked negotiator was the last negotiator into the negotiation' do
        it 'calls finish' do
          negotiation.kick(leaving_negotiator)
          negotiation.should_receive(:finish).and_return(true)
          negotiaiton.kick(negotiation.negotiators.last)
        end
      end
    end

    context 'When given negotiator is not into the negotiation' do
      specify{ negotiation.kick('0').should raise_error }
    end
  end

  describe '#do_new_proposal(proposal_form_hash)' do
    xit 'Adds to negotiation a new proposal from the given hash'
  end

  describe '#post_message(message_form_hash)' do
    xit 'Adds to negotiation a new message from the given hash'
  end

  describe '#can_propose?(negotiator)' do
    it 'Returns true if the given negotiator can propose a deal'
  end

  describe '#propose_deal(negotiator)' do
    xit 'Updates token to set the given negotiator has proposed a deal'
  end

  describe '#can_close?(negotiator)' do
    xit 'Returns true if the given negotiator can close a deal'
  end

  describe '#make_deal' do
    it 'Returns a new deal from the current negotiation'
  end

  describe '#self_update ' do
    xit 'Updates itself'
  end

  describe '#finish' do
    it 'destroy the negotiation' do
      negotiation.should_receive(:destroy).and_return(:true)
      negotiation.finish
    end

    it 'deletes the negotiation from each negotiator in the negotiation' do
      negotiation.finish
      negotiation.negotiators.reload
      negotiation.negotiators.each do |negotiator|
        negotiator.negotiations.should_not include(negotiation)
      end
    end
  end
end
