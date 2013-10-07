require 'spec_helper'

describe Negotiation do

  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:first_user)  { negotiation._users.first }
  let(:second_user) { negotiation._users.last }
  let(:composer_id) { negotiation.proposals.last.composer_id }
  let(:receiver_id) { negotiation.proposals.last.receiver_id }
  let(:_state) { negotiation._state }

  let(:unsigned) {['unsigned']}
  let(:composer_signed) {[composer_id,'signed']}
  let(:receiver_signed) {[receiver_id,'signed']}
  let(:composer_confirmed) {[composer_id,'confirmed']}
  let(:receiver_confirmed) {[receiver_id,'confirmed']}
  let(:receiver_rejected) {[receiver_id,'rejected']}
  let(:nostock) { ['nostock']}
  let(:cash_negotiation) { negotiation.proposals.first.goods<<Fabricate.build(:cash,owner_id:composer_id)}


  # Relations
  it { should have_and_belong_to_many :_users }
  it { should embed_many :proposals }
  it { should embed_many :messages }
  it { should embed_many :user_sheets }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:_previous_state).of_type(Array)}
  it { should have_field(:_state).of_type(Array) }

  # Validations
  it { should_not validate_presence_of :_users }
  it { should validate_presence_of :proposals }
  it { should validate_presence_of :messages }
  it { should validate_presence_of :_state }
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
    it 'sets state to unsigned if composer has cash' do
      negotiation.proposals.first.goods<<Fabricate.build(:cash,owner_id:composer_id)
      expect(negotiation.initial_state).to eq unsigned
    end
    it 'sets state to composer signed if receiver has cash' do
      negotiation.proposals.first.goods<<Fabricate.build(:cash,owner_id:receiver_id)
      expect(negotiation.initial_state).to eq composer_signed
    end
    it 'sets state to composer signed if no cash' do
      expect(negotiation.initial_state).to eq composer_signed
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

  describe '#state' do
    context 'composer has cash' do
      it 'has initial state set to unsigned on #initial_state' do
        expect {cash_negotiation.initial_state}.to change {cash_negotiation.state}.to(unsigned)
      end

      it 'changes to receiver_signed on #sign(receiver_id)' do
        cash_negotiation.initial_state
        cash_negotiation.sign(receiver_id)
        expect{cash_negotiation.sign(receiver_id)}.to change {cash_negotiation.state}.from(unsigned).to(receiver_signed)
      end

      it 'changes to composer_confirmed on #confirm(composer_id)' do
        cash_negotiation.initial_state
        cash_negotiation.sign(receiver_id)
        expect {cash_negotiation.confirm(composer_id)}.to change {cash_negotiation.state}.from(receiver_signed).to(composer_confirmed)
      end
    end

    context 'composer has no cash' do
      it 'has initial_state set to composer_signed on #initial_state' do
        expect{cash_negotiation.initial_state }.to change{cash_negotiation.state}.from(nil).to(composer_signed)
      end

      it 'changes to receiver_confirmed on #confirm(receiver_id)' do
        cash_negotiation.initial_state
        expect{cash_negotiation.confirm(receiver_id)}.to change{cash_negotiation.state}.from(composer_signed).to(receiver_confirmed)
      end
    end
 end

  # Factories
  specify { expect(negotiation).to be_valid }
end