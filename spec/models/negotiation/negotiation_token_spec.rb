require 'spec_helper'

describe Negotiation::Token do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:token) { negotiation.token }
  let(:proposal) { negotiation.proposals.last }
  let(:composer) { proposal.user_composer }
  let(:receiver) { proposal.user_receiver }

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:state).of_type(Symbol) }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :negotiation }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :state }
    it { should validate_inclusion_of(:state).to_allow([:propose, :accept]) }
  end

  describe 'Factories' do
    specify { expect(token).to be_valid }

    it 'creates one negotiation' do
      expect { token.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe '#initialize_token' do
    before { token.initialize_token }

    it 'is in :propose state' do
      expect(token.state).to eq :propose
    end

    context 'when receiver offers money' do
      it 'is owned by the composer' do
        proposal.money.user_id = receiver.id
        proposal.money.quantity = '1000'
        token.initialize_token
        expect(token.user_id).to eq composer.id
      end
    end

    context 'when receiver does not offer money' do
      it 'is owned by the receiver' do
        expect(token.user_id).to eq receiver.id
      end
    end
  end

  describe '#update_token(user_id, state)' do
    before { token.update_token(receiver.id, :accept) }

    it 'has given user_id value' do
      expect(token.user_id).to eq receiver.id
    end

    it 'has given state value' do
      expect(token.state).to eq :accept
    end
  end
end
