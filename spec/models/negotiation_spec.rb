require 'spec_helper'

describe Negotiation do

  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:first_user)  { negotiation._users.first }
  let(:second_user) { negotiation._users.last }
  let(:composer_id) { negotiation.proposals.last.composer_id }
  let(:receiver_id) { negotiation.proposals.last.receiver_id }
  let(:_state) { negotiation.negotiation_state }


  # Relations
  it { should have_and_belong_to_many :_users }
  it { should embed_many :proposals }
  it { should embed_many :messages }
  it { should embed_many :user_sheets }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:previous_state).of_type(Array)}
  it { should have_field(:state).of_type(Array) }

  # Validations
  it { should_not validate_presence_of :_users }
  it { should validate_presence_of :proposals }
  it { should validate_presence_of :messages }
  it { should validate_presence_of :performer }
  it { should validate_presence_of :state }
  it 'should validate_presence_of two user_sheets corresponding to _users'

  # Methods

  describe '#cash?' do
    it 'calls proposal.cash?' do
      expect(negotiation.proposal).to receive(:cash?)
      negotiation.cash?
    end
  end

  describe '#cash_owner' do
    it 'calls proposal.cash_owner' do
      expect(negotiation.proposal).to receive(:cash_owner)
      negotiation.cash_owner
    end
  end

  describe '#proposal' do
    it 'returns the last proposal' do
      negotiation.proposals.build
      expect(negotiation.proposal).to eq negotiation.proposals.last
    end
  end

  describe '#composer' do
    it 'calls proposal.composer_id' do
      expect(negotiation.proposal).to receive(:composer_id)
      negotiation.composer
    end
  end

  describe '#receiver' do
    it 'calls proposal.receiver_id' do
      expect(negotiation.proposal).to receive(:receiver_id)
      negotiation.receiver
    end
  end

  describe '#initial_state' do
    it 'sets state to [composer_id,new] if composer has cash' do
      negotiation.proposals.first.goods<<Fabricate.build(:cash,owner_id:composer_id)
      expect(negotiation.initial_state).to eq [composer_id,'new']
    end
    it 'sets state to [composer_id,signed] if receiver has cash' do
      negotiation.proposals.first.goods<<Fabricate.build(:cash,owner_id:receiver_id)
      expect(negotiation.initial_state).to eq [composer_id,'signed']
    end
    it 'sets state to [composer_id,signed] if no cash' do
      expect(negotiation.initial_state).to eq [composer_id,'signed']
    end
  end

  describe '#sign' do
    it 'calls to _state.trigger(user_id,:sign)' do
      expect(_state).to receive(:trigger).with([composer_id,:sign])
      negotiation.sign(composer_id)
    end
  end

  describe '#confirm' do
    it 'calls to _state.trigger(user_id,:confirm)' do
      expect(_state).to receive(:trigger).with([composer_id,:confirm])
      negotiation.confirm(composer_id)
    end
  end

  describe '#reject' do
    it 'calls to _state.trigger(user_id,:reject)' do
      expect(_state).to receive(:trigger).with([composer_id,:reject])
      negotiation.reject(composer_id)
    end
  end

  describe '#nostock' do
    it 'calls to _state.trigger(:nostock)' do
      expect(_state).to receive(:trigger).with(['nostock'])
      negotiation.nostock
    end
  end

  describe '#restock' do
    it 'calls to _state.trigger(:restock)' do
      expect(_state).to receive(:trigger).with(['restock'])
      negotiation.restock
    end
  end

 describe '#_state' do
  it 'is pending'
 end

  # Factories
  specify { expect(negotiation).to be_valid }
end