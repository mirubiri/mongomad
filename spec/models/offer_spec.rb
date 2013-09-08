require 'spec_helper'

describe Offer do
  # let(:user_composer) { Fabricate(:user_with_things) }
  # let(:user_receiver) { Fabricate(:user_with_things) }
  # let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:offer) { Fabricate.build(:offer) }

  # Relations
  it { should belong_to(:user_sender).of_type(User) }
  it { should belong_to(:user_receiver).of_type(User) }
  it { should embed_one :proposal }
  it { should embed_many :user_sheets } # ¿embed_one?

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :message }

  # Validations
  it { should validate_presence_of :user_sender }
  it { should validate_presence_of :user_receiver }
  it { should validate_presence_of :proposal }
  it { should validate_presence_of :message }
  it { should validate_length_of(:message).within(1..160) }

  #Methods
  describe '#sender' do
    it 'returns the sender user sheet' do
      expect(offer.sender.id).to eq offer.user_sender.id
    end
  end

  describe '#receiver' do
    it 'returns the receiver user sheet' do
      expect(offer.sender.id).to eq offer.user_sender.id
    end
  end

  describe '#negotiate' do
    it 'returns a new saved negotiation with this offer as initial proposal'
    it 'returns false when offer is not saved'
  end

  # Factories
  specify { expect(Fabricate.build(:offer)).to be_valid }

  # describe '#start_negotiation' do
  #   context 'When offer is saved' do
  #     before { offer.save }

  #     let(:negotiation) { offer.start_negotiation }

  #     it 'returns a saved negotiation' do
  #       expect(negotiation).to be_persisted
  #     end

  #     it 'add the negotiation to composer in offer' do
  #       expect(negotiation).to eq offer.user_composer.negotiations.first
  #     end

  #     it 'add the negotiation to receiver in offer' do
  #       expect(negotiation).to eq offer.user_receiver.negotiations.first
  #     end

  #     it 'returns a negotiation whose conversation has only one message' do
  #       expect(negotiation.conversation.messages).to have(1).messages
  #     end

  #     it 'returns a negotiation whose message has the values from original offer' do
  #       expect(negotiation.conversation.messages.last.user_id).to eq offer.user_composer_id
  #       expect(negotiation.conversation.messages.last.text).to eq offer.initial_message
  #     end

  #     it 'returns a negotiation with only one proposal' do
  #       expect(negotiation.proposals).to have(1).proposals
  #     end

  #     it 'returns a negotiation whose proposal has the values from original offer' do
  #       expect(negotiation.proposals.last).to be_like offer
  #     end
  #   end

  #   context 'When offer is not saved' do
  #     it 'returns nil' do
  #       expect(offer.start_negotiation).to eq nil
  #     end
  #   end
  # end
end

