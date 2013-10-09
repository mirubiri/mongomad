require 'spec_helper'

describe Negotiation do

  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:composer_id) { negotiation.proposals.last.composer_id }
  let(:receiver_id) { negotiation.proposals.last.receiver_id }
  let(:negotiation_state) { negotiation.state }
  let(:negotiation_previous_state) { negotiation.previous_state }

  let(:unsigned) {['unsigned']}
  let(:composer_signed) {[composer_id,'signed']}
  let(:receiver_signed) {[receiver_id,'signed']}
  let(:composer_confirmed) {[composer_id,'confirmed']}
  let(:receiver_confirmed) {[receiver_id,'confirmed']}
  let(:receiver_rejected) {[receiver_id,'rejected']}
  let(:composer_rejected) {[composer_id,'rejected']}
  let(:nostock) { ['nostock']}

  # Relations
  it { should have_and_belong_to_many :_users }
  it { should embed_many :proposals }
  it { should embed_many :messages }
  it { should_not embed_many :user_sheets }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:previous_state).of_type(Array)}
  it { should have_field(:state).of_type(Array) }

  # Validations
  it { should_not validate_presence_of :_users }
  it { should validate_presence_of :proposals }
  it { should validate_presence_of :messages }
  it { should validate_presence_of :state }

  it 'is not valid if state is different of initial_state before persisted' do
    negotiation.state=composer_confirmed
    expect(negotiation).to have(1).error_on(:state)
  end

  it 'is valid if state is different of initial_state after persisted' do
    allow(negotiation).to receive(:persisted?).and_return(true)
    negotiation.state=composer_confirmed
    expect(negotiation).to_not have(1).error_on(:state)
  end

  it 'is not valid if state has more than 1 value' do
    negotiation.state=[unsigned,composer_signed]
    expect(negotiation).to have(1).error_on(:state)
  end

  it 'is invalid if state is not included in allowed states list' do
    allow(negotiation).to receive(:persisted?).and_return(true)
    negotiation.state=['other']
    expect(negotiation).to have(1).error_on(:state)
  end

  # Methods
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

  describe '#actions_for' do
    it 'returns an array containing the actions a given user can perform' do
    end

    it 'returns a nil array if a given user cannot perform any action' do
    end
  end

  describe '#initial_state' do
    it 'returns unsigned if composer has cash' do
      negotiation.proposals.first.goods<<Fabricate.build(:cash,owner_id:composer_id)
      expect(negotiation.initial_state).to eq unsigned
    end

    it 'returns composer_signed if receiver has cash' do
      negotiation.proposals.first.goods<<Fabricate.build(:cash,owner_id:receiver_id)
      expect(negotiation.initial_state).to eq composer_signed
    end

    it 'returns composer_signed if no cash' do
      expect(negotiation.initial_state).to eq composer_signed
    end
  end

  describe '#state' do
    # Signs
    it 'changes from unsigned to receiver_signed on sign(receiver_id)' do
      negotiation_state=unsigned
      expect{ negotiation.sign(receiver_id) }.to change { negotiation_state }.to(receiver_signed)
    end

    # Confirmations
    it 'changes from receiver_signed to composer_confirmed on confirm(composer_id)' do
      negotiation_state=receiver_signed
      expect{ negotiation.confirm(composer_id) }.to change{ negotiation_state }.to(composer_confirmed)
    end

    it 'changes from composer_signed to receiver_confirmed on confirm(receiver_id)' do
      negotiation_state=composer_signed
      expect{ negotiation.confirm(receiver_id) }.to change{ negotiation_state }.to(receiver_confirmed)
    end

    # Rejects
    it 'changes from unsigned to receiver_rejected on reject(receiver_id)' do
      negotiation_state=unsigned
      expect{ negotiation.reject(receiver_id) }.to change{ negotiation_state }.to(receiver_rejected)
    end

    it 'changes from composer_signed to receiver_rejected on reject(receiver_id)' do
      negotiation_state=composer_signed
      expect{ negotiation.reject(receiver_id) }.to change { negotiation_state }.to(receiver_rejected)
    end

    it 'changes from receiver_signed to composer_rejected on reject(composer:id)' do
      negotiation_state=receiver_signed
      expect{ negotiation.reject(composer_id) }.to change { negotiation_state }.to(composer_rejected)
    end

    # No stock
    it 'changes from unsigned to nostock on nostock' do
      negotiation_state=unsigned
      expect{ negotiation.nostock }.to change{ negotiation_state }.to(nostock)
    end

    it 'changes from receiver_signed to nostock on nostock' do
      negotiation_state=receiver_signed
      expect{ negotiation.nostock }.to change{ negotiation_state }.to(nostock)
    end

    it 'changes from composer_signed to nostock on nostock' do
      negotiation_state=composer_signed
      expect{ negotiation.nostock }.to change{ negotiation_state }.to(nostock)
    end

    # Restock
    before(:each) { negotiation_state=nostock }
    it 'changes from nostock to previous receiver_signed state on restock' do
      negotiation_previous_state=receiver_signed
      expect{ negotiation.restock }.to change{ negotiation_state }.to( receiver_signed )
    end

    it 'changes from nostock to previous composer_signed state on restock' do
      negotiation_previous_state=composer_signed
      expect{ negotiation.restock }.to change{ negotiation_state }.to( composer_signed )
    end

    it 'changes from nostock to previous unsigned on restock' do
      negotiation_previous_state=unsigned
      expect{ negotiation.restock }.to change{ negotiation_state }.to( unsigned )
    end

  end

  # Factories
  specify { expect(negotiation).to be_valid }
end