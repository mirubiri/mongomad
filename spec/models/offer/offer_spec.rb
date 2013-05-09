require 'spec_helper'

describe Offer do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }

  describe 'Relations' do
    it { should belong_to(:user_composer).of_type(User) }
    it { should belong_to(:user_receiver).of_type(User) }
    it { should embed_one(:composer).of_type(Offer::Composer) }
    it { should embed_one(:receiver).of_type(Offer::Receiver) }
    it { should embed_one(:money).of_type(Offer::Money) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:initial_message).of_type(String) }
    it { should accept_nested_attributes_for :composer }
    it { should accept_nested_attributes_for :receiver }
    it { should accept_nested_attributes_for :money }
  end

  describe 'Validations' do
    it { should validate_presence_of :user_composer }
    it { should validate_presence_of :user_receiver }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :initial_message }
    it { should validate_length_of(:initial_message).within(1..160) }
  end

  describe 'Factories' do
    specify { expect(offer).to be_valid }
    specify { expect(offer.save).to eq true }

    it 'creates two different users' do
      expect { offer.save }.to change{ User.count }.by(2)
    end
  end

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
      offer.save
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
