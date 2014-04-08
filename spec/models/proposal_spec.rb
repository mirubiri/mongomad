require 'spec_helper'

describe Proposal do
  # Variables
  let(:user_composer) { Fabricate.build(:user_with_items) }
  let(:user_receiver) { Fabricate.build(:user_with_items) }
  let(:proposal)      { Fabricate.build(:proposal, composer:user_composer, receiver:user_receiver) }
  let(:composer_id)   { proposal.composer_id }
  let(:receiver_id)   { proposal.receiver_id }

  # Relations
  it { should be_embedded_in :proposal_container }
  it { should embed_many :goods }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:composer_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:receiver_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:state).with_default_value_of('new') }
  it { should have_field(:signer).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:confirmer).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:locked).of_type(Boolean).with_default_value_of(false) }

  # Validations
  it { should_not validate_presence_of :proposal_container }
  it { should validate_presence_of :goods }
  it { should validate_presence_of :composer_id }
  it { should validate_presence_of :receiver_id }
  it { should validate_inclusion_of(:state).to_allow('new','signed','confirmed') }
  it { should validate_presence_of :locked }

  # Checks
  it 'is invalid if composer and receiver are the same' do
    proposal.receiver_id = composer_id
    expect(proposal).to have(1).error_on(:users)
    expect(proposal.errors_on(:users)).to include('Composer and receiver should not be equal.')
  end

  it 'is invalid if composer has no goods' do
    proposal.goods.delete_all(owner_id:composer_id)
    expect(proposal).to have(1).error_on(:goods)
    expect(proposal.errors_on(:goods)).to include('Composer should have one good at least.')
  end

  it 'is invalid if receiver has no goods' do
    proposal.goods.delete_all(owner_id:receiver_id)
    expect(proposal).to have(1).error_on(:goods)
    expect(proposal.errors_on(:goods)).to include('Receiver should have one good at least.')
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
    proposal.goods << Fabricate.build(:cash, owner_id:composer_id)
    proposal.goods << Fabricate.build(:cash, owner_id:receiver_id)
    expect(proposal).to have(1).error_on(:goods)
    expect(proposal.errors_on(:goods)).to include('Proposal should have only one cash.')
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

  describe 'articles' do
    it 'returns articles for given user' do
      owner_id = proposal.goods.sample.owner_id
      expect(proposal.goods).to receive(:where).with(owner_id:owner_id)
      proposal.articles(owner_id)
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

  describe '#state_machine' do
    subject(:machine) { double().as_null_object }
    before(:each) { proposal.state_machine(machine) }

    it { should have_received(:when).with(:sign, 'new' => 'signed') }
    it { should have_received(:when).with(:confirm, 'signed' => 'confirmed') }
    it { should have_received(:when).with(:reset, 'signed' => 'new') }
  end

  shared_examples 'valid state machine event' do |action, user_id, initial_state, final_state|
    before(:each) { proposal.state = initial_state }
    let(:test_code) { "random_test_code:#{Faker::Number.number(8)}" }

    it "calls state_machine.trigger(#{action})" do
      expect(proposal.state_machine).to receive(:trigger).with(action)
      proposal.send(action, user_id)
    end

    it "changes proposal state from #{initial_state} to #{final_state}" do
      expect { proposal.send(action, user_id) }.to change { proposal.state }.from(initial_state).to(final_state)
    end

    it 'does not save the proposal' do
      proposal.send(action, user_id)
      expect(proposal).to_not be_persisted
    end

    it "returns the result of calling state_machine.trigger(#{action})" do
      proposal.state_machine.stub(:trigger).with(action) { test_code }
      expect(proposal.send(action, user_id)).to eq test_code
    end
  end

  shared_examples 'invalid state machine event' do |action, user_id, initial_state, final_state|
    before(:each) { proposal.state = initial_state }

    it "does not call state_machine.trigger(#{action})" do
      expect(proposal.state_machine).to_not receive(:trigger).with(action)
      proposal.send(action, user_id)
    end

    it 'does not change proposal state' do
      expect { proposal.send(action, user_id) }.to_not change { proposal.state }
    end

    it 'does not change proposal locked field' do
      expect { proposal.send(action, user_id) }.to_not change { proposal.locked }
    end

    it 'returns false' do
      expect(proposal.send(action, user_id)).to eq false
    end
  end

  describe '#sign' do
    it 'does not change confirmer field' do
      expect { proposal.sign(composer_id) }.to_not change { proposal.confirmer }
    end

    context 'when proposal is locked' do
      before(:each) { proposal.locked = true }
      it_should_behave_like 'invalid state machine event', :sign, :composer_id, 'new', 'signed'

      it 'does not change signer field' do
        expect { proposal.sign(composer_id) }.to_not change { proposal.signer }
      end
    end

    context 'when proposal is unlocked' do
      before(:each) { proposal.locked = false }
      it_should_behave_like 'valid state machine event', :sign, :composer_id, 'new', 'signed'

      it 'given user signs proposal' do
        proposal.sign(composer_id)
        expect(proposal.signer).to eq composer_id
      end

      it 'does not change proposal locked field' do
        expect { proposal.sign(composer_id) }.to_not change { proposal.locked }
      end
    end
  end

  describe '#confirm' do
    it 'does not change signer field' do
      expect { proposal.confirm(composer_id) }.to_not change { proposal.signer }
    end

    context 'when proposal is locked' do
      before(:each) { proposal.locked = true }
      it_should_behave_like 'invalid state machine event', :confirm, :composer_id, 'signed', 'confirmed'

      it 'does not change confirmer field' do
        expect { proposal.confirm(composer_id) }.to_not change { proposal.confirmer }
      end
    end

    context 'when proposal is unlocked' do
      before(:each) { proposal.locked = false }
      it_should_behave_like 'valid state machine event', :confirm, :composer_id, 'signed', 'confirmed'

      it 'confirms proposal by user' do
        proposal.confirm(composer_id)
        expect(proposal.confirmer).to eq composer_id
      end

      it 'changes proposal locked field to true' do
        expect { proposal.confirm(composer_id) }.to change { proposal.locked }.from(false).to(true)
      end
    end
  end

  describe '#reset' do
    before(:each) { proposal.state = 'signed' }

    context 'when proposal is locked' do
      before(:each) { proposal.locked = true }

      it 'does not call state_machine.trigger(:reset)' do
        expect(proposal.state_machine).to_not receive(:trigger).with(:reset)
        proposal.reset
      end

      it 'does not change proposal state' do
        expect { proposal.reset }.to_not change { proposal.state }
      end

      it 'does not change signer field' do
        expect { proposal.reset }.to_not change { proposal.signer }
      end

      it 'does not change confirmer field' do
        expect { proposal.reset }.to_not change { proposal.confirmer }
      end

      it 'does not change proposal locked field' do
        expect { proposal.reset }.to_not change { proposal.locked }
      end

      it 'returns false' do
        expect(proposal.reset).to eq false
      end
    end

    context 'when proposal is unlocked' do
      before(:each) { proposal.locked = false }

      it 'calls state_machine.trigger(:reset)' do
        expect(proposal.state_machine).to receive(:trigger).with(:reset)
        proposal.reset
      end

      it 'changes proposal state from :signed to :new' do
        expect { proposal.reset }.to change { proposal.state }.from('signed').to('new')
      end

      it 'unsigns proposal' do
        proposal.reset
        expect(proposal.signer).to eq nil
      end

      it 'unconfirms proposal' do
        proposal.reset
        expect(proposal.confirmer).to eq nil
      end

      it 'does not change proposal locked field' do
        expect { proposal.reset }.to_not change { proposal.locked }
      end

      it 'does not save the proposal' do
        proposal.reset
        expect(proposal).to_not be_persisted
      end

      it 'returns the result of calling state_machine.trigger(:reset)' do
        test_code = "random_test_code:#{Faker::Number.number(8)}"
        proposal.state_machine.stub(:trigger).with(:reset) { test_code }
        expect(proposal.reset).to eq test_code
      end
    end
  end

  describe '#update_state' do
    before { proposal.goods << Fabricate.build(:cash, owner_id:composer_id) }

    context 'when proposal is locked' do
      before(:each) { proposal.locked = true }

      it 'does not call reset method' do
        expect(proposal).to_not receive(:reset)
        proposal.update_state
      end

      it 'does not change proposal state' do
        expect { proposal.update_state }.to_not change { proposal.state }
      end

      it 'does not change signer field' do
        expect { proposal.update_state }.to_not change { proposal.signer }
      end

      it 'does not change confirmer field' do
        expect { proposal.update_state }.to_not change { proposal.confirmer }
      end

      it 'does not change proposal locked field' do
        expect { proposal.update_state }.to_not change { proposal.locked }
      end

      it 'returns false' do
        expect(proposal.update_state).to eq false
      end
    end

    context 'when proposal is unlocked' do
      before(:each) { proposal.locked = false }

      context 'when all products are on sale' do
        before(:each) do
          proposal.goods.type(Product).each do |product|
            product.state = 'on_sale'
          end
        end

        it 'does not change proposal locked field' do
          expect { proposal.update_state }.to_not change { proposal.locked }
        end

        context 'when proposal is in new state' do
          before(:each) { proposal.state = 'new' }

          it 'does not call reset method' do
            expect(proposal).to_not receive(:reset)
            proposal.update_state
          end

          it 'does not change proposal state' do
            expect { proposal.update_state }.to_not change { proposal.state }
          end

          it 'does not change signer field' do
            expect { proposal.update_state }.to_not change { proposal.signer }
          end

          it 'does not change confirmer field' do
            expect { proposal.update_state }.to_not change { proposal.confirmer }
          end

          it 'returns true' do
            expect(proposal.update_state).to eq true
          end
        end

        context 'when proposal is in signed state' do
          before(:each) { proposal.state = 'signed' }
          let(:test_code) { "random_test_code:#{Faker::Number.number(8)}" }

          it 'calls reset method' do
            expect(proposal).to receive(:reset)
            proposal.update_state
          end

          it 'changes proposal state from signed to new' do
            expect { proposal.update_state }.to change { proposal.state }.from('signed').to('new')
          end

          it 'unsigns proposal' do
            proposal.update_state
            expect(proposal.signer).to eq nil
          end

          it 'unconfirms proposal' do
            proposal.update_state
            expect(proposal.confirmer).to eq nil
          end

          it 'returns the result of calling reset' do
            proposal.stub(:reset) { test_code }
            expect(proposal.update_state).to eq test_code
          end
        end
      end

      context 'when any product is not on sale' do
        before(:each) { proposal.goods.type(Product).first.state = 'sold' }

        it 'does not call reset method' do
          expect(proposal).to_not receive(:reset)
          proposal.update_state
        end

        it 'does not change proposal state' do
          expect { proposal.update_state }.to_not change { proposal.state }
        end

        it 'does not change signer field' do
          expect { proposal.update_state }.to_not change { proposal.signer }
        end

        it 'does not change confirmer field' do
          expect { proposal.update_state }.to_not change { proposal.confirmer }
        end

        it 'changes proposal locked field from false to true' do
          expect { proposal.update_state }.to change { proposal.locked }.from(false).to(true)
        end

        it 'returns true' do
          expect(proposal.update_state).to eq true
        end
      end
    end
  end

  describe '#lock' do
    it 'sets locked field to true' do
      proposal.lock
      expect(proposal.locked).to eq true
    end
  end

  # Factories
  specify { expect(Fabricate.build(:proposal)).to be_valid }
end
