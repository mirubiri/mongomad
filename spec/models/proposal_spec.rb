require 'spec_helper'

describe Proposal do
  # Variables
  let(:proposal) { Fabricate.build(:proposal) }

  # Relations
  it { should be_embedded_in :proposal_container }
  it { should embed_many :user_sheets }
  it { should embed_many :goods }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:composer_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:receiver_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:state).with_default_value_of('new') }

  # Validations
  it { should_not validate_presence_of :proposal_container }
  it { should validate_presence_of :user_sheets }
  it { should validate_presence_of :goods }
  it { should validate_presence_of :composer_id }
  it { should validate_presence_of :receiver_id }
  it { should validate_inclusion_of(:state).to_allow('new','signed','confirmed','broken','ghosted','discarded') }

  it 'is invalid when there is any good for composer' do
    composer_id = proposal.composer_id
    proposal.goods.delete_all(owner_id:composer_id)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid when there is any good for receiver' do
    receiver_id = proposal.receiver_id
    proposal.goods.delete_all(owner_id:receiver_id)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid if any good is not owned by composer or receiver' do
    proposal.goods << Fabricate.build(:product)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid if a good is duplicated' do
    good = proposal.goods.sample
    proposal.goods << good
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid when there is more than one cash in goods' do
    proposal.goods << Fabricate.build(:cash, owner_id:proposal.composer_id)
    proposal.goods << Fabricate.build(:cash, owner_id:proposal.receiver_id)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid when there is any sheet for composer_id' do
    proposal.composer_id = nil
    expect(proposal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid when there is any sheet for receiver_id' do
    proposal.receiver_id = nil
    expect(proposal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there are more than two user sheets' do
    proposal.user_sheets << Fabricate.build(:user_sheet)
    expect(proposal).to have(1).error_on(:user_sheets)
  end

  # Methods
  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }

    before(:each) { proposal.state_machine(machine) }

    it { should have_received(:when).with(:sign, 'new' => 'signed') }


    it { should have_received(:when).with(:confirm, 'signed' => 'confirmed') }

    it { should have_received(:when).with(:break, 'new' => 'broken',
                                                  'signed' => 'broken') }

    it { should have_received(:when).with(:reset, 'signed' => 'new',
                                                  'broken' => 'new') }

    it { should have_received(:when).with(:ghost, 'new' => 'ghosted',
                                                  'signed' => 'ghosted',
                                                  'broken' => 'ghosted') }

    it { should have_received(:when).with(:discard, 'ghosted' => 'discarded') }
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

  describe '#break' do
    it_should_behave_like 'an state machine event', :break, 'new', 'broken'
  end

  describe '#reset' do
    it_should_behave_like 'an state machine event', :reset, 'signed', 'new'
  end

  describe '#ghost' do
    it_should_behave_like 'an state machine event', :ghost, 'broken', 'ghosted'
  end

  describe '#discard' do
    it_should_behave_like 'an state machine event', :discard, 'ghosted', 'discarded'
  end

  describe '#composer' do
    it 'returns the composer user sheet' do
      expect(proposal.composer).to eq proposal.user_sheets.find(proposal.composer_id)
    end
  end

  describe '#receiver' do
    it 'returns the receiver user sheet' do
      expect(proposal.receiver).to eq proposal.user_sheets.find(proposal.receiver_id)
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
    it 'returns true if there is cash in proposal' do
      proposal.goods.build({}, Cash)
      expect(proposal.cash?).to eq true
    end

    it 'returns false if there is no cash in proposal' do
      expect(proposal.cash?).to eq false
    end
  end

  # Factories
  specify { expect(Fabricate.build(:proposal)).to be_valid }
end
