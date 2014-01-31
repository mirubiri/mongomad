require 'spec_helper'

describe Proposal do
  let(:proposal) { Fabricate.build(:proposal) }

  # Relations
  it { should be_embedded_in :proposal_container }
  it { should embed_many :goods }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:composer_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:receiver_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:state).with_default_value_of('new') }

  # Validations
  it { should_not validate_presence_of :proposal_container }
  it { should validate_presence_of :goods }
  it { should validate_presence_of :composer_id }
  it { should validate_presence_of :receiver_id }
  it { should validate_inclusion_of(:state).to_allow('new','signed','confirmed','broken','ghosted','discarded') }

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
  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }
    before(:each) { proposal.state_machine(machine) }

    it { should have_received(:when).with(:sign, 'new' => 'signed') }
    it { should have_received(:when).with(:confirm, 'signed' => 'confirmed') }
    it { should have_received(:when).with(:break, 'new' => 'broken', 'signed' => 'broken') }
    it { should have_received(:when).with(:reset, 'signed' => 'new', 'broken' => 'new') }
    it { should have_received(:when).with(:ghost, 'new' => 'ghosted', 'signed' => 'ghosted', 'broken' => 'ghosted') }
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

  describe '#update_state' do
    shared_examples 'active state' do
      let(:test_code) { "random_test_code:#{Faker::Number.number(8)}" }

      context 'when proposal contains only available products' do
        it 'returns the result of calling #reset' do
          proposal.stub(:reset) { test_code }
          expect(proposal.update_state).to eq proposal.reset
        end
      end

      context 'when proposal contains unavailable and ghosted products' do
        before do
          proposal.goods.first.unavailable
          proposal.goods.last.ghost
        end

        it 'returns the result of calling #ghost' do
          proposal.stub(:ghost) { test_code }
          expect(proposal.update_state).to eq proposal.ghost
        end
      end

      #TODO: Remove if discarded state for product is removed
      context 'when proposal contains unavailable and discarded products' do
        before do
          proposal.goods.first.unavailable
          proposal.goods.last.ghost
          proposal.goods.last.discard
        end

        it 'returns the result of calling #ghost' do
          proposal.stub(:ghost) { test_code }
          expect(proposal.update_state).to eq proposal.ghost
        end
      end

      context 'when proposal contains unavailable products and no ghosted or discarded ones' do
        before { proposal.goods.first.unavailable }

        it 'returns the result of calling #break' do
          proposal.stub(:break) { test_code }
          expect(proposal.update_state).to eq proposal.break
        end
      end

      context 'when proposal contains a ghosted product' do
        before { proposal.goods.first.ghost }

        it 'returns the result of calling #ghost' do
          proposal.stub(:ghost) { test_code }
          expect(proposal.update_state).to eq proposal.ghost
        end
      end

      #TODO: Remove if discarded state for product is removed
      context 'when proposal contains a discarded product' do
        before do
          proposal.goods.first.ghost
          proposal.goods.first.discard
        end

        it 'returns the result of calling #ghost' do
          proposal.stub(:ghost) { test_code }
          expect(proposal.update_state).to eq proposal.ghost
        end
      end
    end

    shared_examples 'inactive state' do
      it 'returns false' do
        expect(proposal.update_state).to eq false
      end

      it 'does not change proposal state' do
        expect{ proposal.update_state }.to_not change{ proposal.state }
      end
    end

    context 'when state is new' do
      include_examples 'active state'
    end

    context 'when state is signed' do
      before { proposal.sign }
      include_examples 'active state'
    end

    context 'when state is confirmed' do
      before do
        proposal.sign
        proposal.confirm
      end
      include_examples 'inactive state'
    end

    context 'when state is broken' do
      before { proposal.break }
      include_examples 'active state'
    end

    context 'when state is ghosted' do
      before { proposal.ghost }
      include_examples 'inactive state'
    end

    context 'when state is discarded' do
      before do
        proposal.ghost
        proposal.discard
      end
      include_examples 'inactive state'
    end
  end

  describe '#composer' do
    it 'calls to proposal_container.user_sheets.find with composer_id' do
      expect(proposal.proposal_container.user_sheets).to receive(:find).with(proposal.composer_id)
      proposal.composer
    end

    it 'returns the composer user sheet' do
      expect(proposal.composer).to eq proposal.proposal_container.user_sheets.find(proposal.composer_id)
    end
  end

  describe '#receiver' do
    it 'calls to proposal_container.user_sheets.find with receiver_id' do
      expect(proposal.proposal_container.user_sheets).to receive(:find).with(proposal.receiver_id)
      proposal.receiver
    end

    it 'returns the receiver user sheet' do
      expect(proposal.receiver).to eq proposal.proposal_container.user_sheets.find(proposal.receiver_id)
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
