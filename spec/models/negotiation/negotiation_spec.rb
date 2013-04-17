require 'spec_helper'

describe Negotiation do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }

  describe 'Relations' do
    it { should have_and_belong_to_many(:negotiators).of_type(User) }
    it { should embed_one(:conversation).of_type(Negotiation::Conversation) }
    it { should embed_many(:proposals).of_type(Negotiation::Proposal) }
    it { should embed_one(:token).of_type(Negotiation::Token) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should accept_nested_attributes_for :conversation }
    it { should accept_nested_attributes_for :proposals }
    it { should accept_nested_attributes_for :token }
  end

  describe 'Validations' do
    xit { should validate_presence_of :negotiators }
    it { should validate_presence_of :conversation }
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :token }
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

=begin
  describe '#kick(negotiator)' do
    let(:leaving_negotiator) { negotiation.negotiators.first }

    context 'When negotiator is in negotiation' do
      it 'kicks a given negotiator from the negotiation' do
        negotiation.kick(leaving_negotiator)
        expect(negotiation.negotiators).to_not include(leaving_negotiator)
      end

      it 'removes the negotiation from the kicked negotiator' do
        negotiation.kick(leaving_negotiator)
        leaving_negotiator.reload
        expect(leaving_negotiator.negotiations).to_not include(negotiation)
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
      specify { expect(negotiation.kick(Fabricate(:user))).to eq true }
    end
  end

  describe '#propose(params)' do
   xit 'makes a new proposition'
  end

  describe '#post_message(params)' do
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

  describe '#seal(negotiator)' do
    xit 'makes a deal with the current proposal as agreement'
    xit 'finish the negotiation'



 describe '#start_negotiation' do
    let!(:negotiation) { offer.start_negotiation }

    it 'returns a negotiation whose conversation has only one message' do
      expect(negotiation.conversation.messages).to have(1).messages
    end

    it 'returns a negotiation whose message has the values from original offer' do
      expect(negotiation.conversation.messages.last.user_id).to eq offer.user_composer_id
      expect(negotiation.conversation.messages.last.text).to eq offer.initial_message
    end

    it 'returns a negotiation with only one proposal' do
      expect(negotiation.proposals).to have(1).proposals
    end

    it 'returns a negotiation whose proposal has the values from original offer' do
      expect(negotiation.proposals.last).to be_like offer
    end

    it 'returns a saved negotiation' do
      expect(negotiation).to be_persisted
    end

    it 'add the negotiation to composer in offer' do
      expect(offer.user_composer.negotiations.first).to eq negotiation
    end

    it 'add the negotiation to receiver in offer' do
      expect(offer.user_receiver.negotiations.first).to eq negotiation
    end
  end


  end
=end
end
