require 'spec_helper'

describe Proposal do
  let(:user_composer) { Fabricate.build(:user_with_items) }
  let(:user_receiver) { Fabricate.build(:user_with_items) }
  let(:proposal) { Fabricate.build(:proposal, composer:user_composer, receiver:user_receiver) }

  # Relations
  it { should be_embedded_in :proposal_container }
  it { should embed_many :goods }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:composer_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:receiver_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:state).with_default_value_of('new') }
  it { should have_field(:actionable).of_type(Boolean).with_default_value_of(true) }

  # Validations
  it { should_not validate_presence_of :proposal_container }
  it { should validate_presence_of :goods }
  it { should validate_presence_of :composer_id }
  it { should validate_presence_of :receiver_id }
  it { should validate_inclusion_of(:state).to_allow('new','signed','confirmed') }
  it { should validate_presence_of :actionable }

  # Checks
  it 'is invalid if composer and receiver are the same' do
    proposal.receiver_id = proposal.composer_id
    expect(proposal).to have(1).error_on(:users)
    expect(proposal.errors_on(:users)).to include('Composer and receiver should not be equal.')
  end

  it 'is invalid if composer has no goods' do
    proposal.goods.delete_all(owner_id:proposal.composer_id)
    expect(proposal).to have(1).error_on(:goods)
    expect(proposal.errors_on(:goods)).to include('Composer should have at least one good.')
  end

  it 'is invalid if receiver has no goods' do
    proposal.goods.delete_all(owner_id:proposal.receiver_id)
    expect(proposal).to have(1).error_on(:goods)
    expect(proposal.errors_on(:goods)).to include('Receiver should have at least one good.')
  end

  it 'is invalid if there is any good not owned by one of the users' do
    proposal.goods << Fabricate.build(:product)
    expect(proposal).to have(1).error_on(:goods)
    expect(proposal.errors_on(:goods)).to include('All goods should be owned by composer or receiver.')
  end

  it 'is invalid if there is any duplicated good' do
    proposal.goods << proposal.goods.sample
    expect(proposal).to have(1).error_on(:goods)
    expect(proposal.errors_on(:goods)).to include('Proposal should not have any duplicated good.')
  end

  it 'is invalid if there are more than one cash' do
    proposal.goods << Fabricate.build(:cash, owner_id:proposal.composer_id)
    proposal.goods << Fabricate.build(:cash, owner_id:proposal.receiver_id)
    expect(proposal).to have(1).error_on(:goods)
    expect(proposal.errors_on(:goods)).to include('Proposal should not have more than one cash.')
  end

  # Methods
  describe '#composer' do
    let(:user_sheet) { user_composer.sheet }

    it 'returns the composer user sheet' do
      expect(proposal.composer).to eq user_sheet
    end
  end

  describe '#receiver' do
    let(:user_sheet) { user_receiver.sheet }

    it 'returns the receiver user sheet' do
      expect(proposal.receiver).to eq user_sheet
    end
  end

  describe 'products(owner_id)' do
    it 'returns products for given user' do
      owner_id = proposal.goods.sample.owner_id
      expect(proposal.goods).to receive(:where).with(owner_id:owner_id)
      proposal.products(owner_id)
    end
  end

  describe '#cash?' do
    context 'when there is cash in proposal' do
      it 'returns true' do
        proposal.goods.build({}, Cash)
        expect(proposal.cash?).to eq true
      end
    end

    context 'when there is no cash in proposal' do
      it 'returns false' do
        expect(proposal.cash?).to eq false
      end
    end
  end

  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }
    before(:each) { proposal.state_machine(machine) }

    it { should have_received(:when).with(:sign, 'new' => 'signed') }
    it { should have_received(:when).with(:confirm, 'signed' => 'confirmed') }
  end

  shared_examples 'an state machine event' do |action, initial_state, final_state|
    before(:each) { proposal.state = initial_state }

    it "calls state_machine.trigger(#{action})" do
      expect(proposal.state_machine).to receive(:trigger).with(action)
      proposal.send(action)
    end

    it "changes proposal state from #{initial_state} to #{final_state}" do
      expect{ proposal.send(action) }.to change { proposal.state }.from(initial_state).to(final_state)
    end

    it 'does not save the proposal' do
      proposal.send(action)
      expect(proposal).to_not be_persisted
    end
  end

  describe '#sign' do
    it_should_behave_like 'an state machine event', :sign, 'new', 'signed'
  end

  describe '#confirm' do
    it_should_behave_like 'an state machine event', :confirm, 'signed', 'confirmed'
  end

  describe '#update_state' do

  context





























    pending "#update_state"
  end

  describe '#actionable?' do
    context 'when proposal is actionable' do
      before(:each) { proposal.actionable = true }

      it 'returns true' do
        expect(proposal.actionable?).to eq true
      end
    end

    context 'when proposal is not actionable' do
      before(:each) { proposal.actionable = false }

      it 'returns false' do
        expect(proposal.actionable?).to eq false
      end
    end
  end

  describe '#deactivate' do
    context 'when proposal is actionable' do
      before(:each) { proposal.actionable = true }

      it 'changes proposal actionable field to false' do
        expect{ proposal.deactivate }.to change{ proposal.actionable }.from(true).to(false)
      end

      it 'returns true' do
        expect(proposal.deactivate).to eq true
      end
    end

    context 'when proposal is not actionable' do
      before(:each) { proposal.actionable = false }

      it 'does not change proposal actionable field' do
        expect{ proposal.deactivate }.to_not change{ proposal.actionable }
      end

      it 'returns false' do
        expect(proposal.deactivate).to eq false
      end
    end
  end

  # Factories
  specify { expect(Fabricate.build(:proposal)).to be_valid }
end
