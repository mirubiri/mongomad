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
    it { should embed_one(:conversation).of_type(Negotiation::Conversation) }
    it { should have_and_belong_to_many(:negotiators).of_type(User) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :conversation }
    it { should validate_presence_of :negotiators }
  end

  describe 'Factories' do
    specify { expect(negotiation.valid?).to eq true }
    specify { expect(negotiation.save).to eq true }

    it 'creates one offer' do
      expect { negotiation.save }.to change{ Offer.count }.by(1)
    end

    it 'creates two different users' do
      expect { negotiation.save }.to change{ User.count }.by(2)
    end
  end

  describe '.generate(offer)' do
    it 'generates a new negotiation with the given offer as current proposal' do
      Negotiation.start_with(offer).should be_valid
    end

    it 'raise error if the given offer is not valid' do
      offer.stub(:valid?).and_return false
      Negotiation.start_with(offer).should raise_error
      pending 'Choose wich exception to throw'
    end

    specify { new_negotiation.negotiators.should include(offer.user_composer,offer.user_receiver) }
  end

  describe '#publish' do
    xit 'saves the negotiation'
  end

  describe '#unpublish' do
    xit 'removes the negotiation'
  end

  describe '#self_update' do
    xit 'updates itself'
  end

  describe '#kick(negotiator)' do
    let(:leaving_negotiator) { negotiation.negotiators.first }

    context 'When negotiator is in negotiation' do
      it 'kicks a given negotiator from the negotiation' do
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
          negotiation.kick(negotiation.negotiators.last)
        end
      end
    end

    context 'When given negotiator is not into the negotiation' do
      specify{ negotiation.kick(Fabricate(:user)).should eq true }
    end
  end

  describe '#propose(proposal_params)' do
    let(:proposal) { negotiation.proposals.first }
    let(:proposal_params) do
      {
        user_composer_id: proposal.user_composer_id,
        user_receiver_id: proposal.user_receiver_id,
        composer_things:  proposal.composer.products.map do |product|
          { thing_id: product[:thing_id], quantity: product[:quantity] }
        end,
        receiver_things:  proposal.receiver.products.map do |product|
          { thing_id: product[:thing_id], quantity: product[:quantity] }
        end,
        money: { user_id: proposal.money.user_id, quantity: proposal.money.quantity },
      }
    end

    context 'when negotiators match with composer and receiver in given hash' do
      before { negotiation.should_receive(:check_negotiators).with(proposal_params).and_return(true) }

      it 'calls to proposal.generate with the given hash' do
        Negotiation::Proposal.should_receive(:generate).with(proposal_params)
        negotiation.make_proposal(proposal_params)
      end

      it 'adds a new proposal' do
        expect { negotiation.make_proposal(proposal_params) }.to change { negotiation.proposals.count }.by(1)
      end

      specify { negotiation.make_proposal(proposal_params).should eq true }
    end

    context 'when negotiators do not match with composer and receiver in given hash' do
      before { negotiation.should_receive(:check_negotiators).with(proposal_params).and_return(false) }

      it 'raise error' do
        negotiation.make_proposal(proposal_params).should raise_error
      end

      it 'does not add a new proposal' do
        expect { negotiation.make_proposal(proposal_params) }.to_not change {negotiation.proposals.count}.by(1)
      end
    end
  end

  describe '#post_message(message_params)' do
    xit 'post a new message into the negotiation'
  end

  describe '#can_sign?(negotiator)' do
    xit 'returns true if the given negotiator can sign the negotiation with the current proposal'
  end

  describe '#sign(negotiator)' do
    xit 'makes a negotiator to sign the deal with the current proposal'
  end

  describe '#can_seal?(negotiator)' do
    xit 'returns true if the given negotiator can seal the deal'
  end

  describe '#seal' do
    xit 'makes a deal with the current proposal as agreement'
    xit 'finish the negotiation'
  end
end
