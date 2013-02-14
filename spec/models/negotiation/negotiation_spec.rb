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

    it 'creates one offer' do
      expect { negotiation.save }.to change{ Offer.count }.by(1)
    end

    it 'creates two different users' do
      expect { negotiation.save }.to change{ User.count }.by(2)
    end
  end

  describe '.start_with(offer)' do
    it 'generates a new negotiation with the given offer as current proposal' do
      Negotiation.start_with(offer).should be_valid
    end

    it 'raise error if the given offer is not valid' do
      offer.should_receive(:valid?).and_return(:false)
      Negotiation.start_with(offer).should raise_error
      pending 'Choose wich exception to throw'
    end

    xit 'it updates the new negotiation' # PIIIIENSAR

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

  describe '#current_proposal' do
    it 'returns the last proposed proposal'
  end

  describe '#make_proposal(proposal_form_hash)' do

    context 'when negotiators match with composer and receiver in given hash' do
      before { negotiation.should_receive(:check_negotiators).with(proposal_form_hash).and_return(true) }
      
      it 'calls to proposal.generate with the given hash' do
        Negotiation::Proposal.should_receive(:generate).with(proposal_form_hash)
        negotiation.make_proposal(proposal_form_hash)
      end

      it 'adds a new proposal' do
        expect { negotiation.make_proposal(proposal_form_hash) }.to change {negotiation.proposals.count}.by(1)
      end

      specify { negotiation.make_proposal(proposal_form_hash).should be_true }
    end
    
    context 'when negotiators do not match with composer and receiver in given hash' do
      before { negotiation.should_receive(:check_negotiators).with(proposal_form_hash).and_return(false) }

      it 'raise error' do
        negotiation.make_proposal(proposal_form_hash).should raise_error
      end

      it 'does not add a new proposal' do
        expect { negotiation.make_proposal(proposal_form_hash) }.to_not change {negotiation.proposals.count}.by(1)
      end
    end
  end

  describe '#post_message(message_form_hash)' do
    xit 'post a new message into the negotiation'
  end

  describe '#can_agree?(negotiator)' do
    xit 'returns true if the given negotiator can agree with the current proposal'
  end

  describe '#agree(negotiator)' do
    xit 'makes a negotiator to agree with the current proposal'
  end

  describe '#can_make_deal?(negotiator)' do
    xit 'returns true if the given negotiator has the opportunity of make a deal'
  end

  describe '#make_deal' do
    xit 'makes a deal with the current proposal as agreement'
    xit 'finish the negotiation'
  end

  describe '#self_update ' do
    xit 'updates itself'
  end

  describe '#finish' do
    it 'destroy the negotiation' do
      negotiation.should_receive(:destroy).and_return(:true)
      negotiation.finish
    end

    it 'removes the negotiation from each negotiator participating in' do
      negotiation.finish
      negotiation.negotiators.reload
      negotiation.negotiators.each do |negotiator|
        negotiator.negotiations.should_not include(negotiation)
      end
    end
  end
end
