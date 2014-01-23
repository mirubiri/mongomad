require 'spec_helper'

describe Negotiation do
  # Variables
  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:composer_id) { negotiation.proposal.composer_id }
  let(:receiver_id) { negotiation.proposal.receiver_id }

  let(:negotiation_composer_cash) do
    negotiation.proposal.goods << Fabricate.build(:cash, owner_id:composer_id)
    negotiation
  end

  let(:negotiation_receiver_cash) do
    negotiation.proposal.goods << Fabricate.build(:cash, owner_id:receiver_id)
    negotiation
  end

  # Relations
  it { should have_and_belong_to_many :users }
  it { should have_one :offer }
  it { should embed_many :user_sheets }
  it { should embed_many :proposals }
  it { should embed_many :messages }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:state).with_default_value_of('open') }

  # Validations
  it { should validate_presence_of :users }
  it { should_not validate_presence_of :offer }
  it { should validate_presence_of :user_sheets }
  it { should validate_presence_of :proposals }
  it { should validate_presence_of :messages }
  it { should validate_inclusion_of(:state).to_allow('open','successful','ghosted','closed') }

  # Checks
  it 'is invalid if there are more than two users' do
    negotiation.users << Fabricate.build(:user)
    expect(negotiation).to have(1).error_on(:users)
  end

  it 'is invalid if both users are the same' do
    negotiation.users[1]._id = negotiation.users[0]._id
    expect(negotiation).to have(1).error_on(:users)
  end

  it 'is invalid if there are more than two user sheets' do
    negotiation.user_sheets << Fabricate.build(:user_sheet)
    expect(negotiation).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there is no sheet for first user' do
    negotiation.users[0]._id = nil
    expect(negotiation).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there is no sheet for second user' do
    negotiation.users[1]._id = nil
    expect(negotiation).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there is any proposal not owned by both users' do
    negotiation.proposals << Fabricate.build(:proposal, composer:negotiation.users.first)
    expect(negotiation).to have(1).error_on(:proposals)
  end

  it 'is invalid if there is any message not owned by any of the users' do
    negotiation.messages << Fabricate.build(:message)
    expect(negotiation).to have(1).error_on(:messages)
  end

  # Methods
  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }

    before(:each) { negotiation.state_machine(machine) }

    it { should have_received(:when).with(:success, 'open' => 'successful') }

    it { should have_received(:when).with(:ghost, 'open' => 'ghosted') }

    it { should have_received(:when).with(:close, 'ghosted' => 'closed' )}

    it { should have_received(:when).with(:reset, 'ghosted' => 'open') }

    it { should have_received(:when).with(:reopen, 'closed' => 'open') }
  end

  shared_examples 'an state machine event' do |action, initial_state, final_state|
    before(:each) { negotiation.state = initial_state }

    it "calls state_machine.trigger(#{action})" do
      expect(negotiation.state_machine).to receive(:trigger).with(action)
      negotiation.send(action)
    end

    it "changes negotiation state from #{initial_state} to #{final_state}" do
      expect{ negotiation.send(action) }.to change { negotiation.state }.from(initial_state).to(final_state)
    end

    it 'does not save the negotiation' do
      negotiation.send(action)
      expect(negotiation).to_not be_persisted
    end
  end

  describe '#success' do
    it_should_behave_like 'an state machine event', :success, 'open', 'successful'
  end

  describe '#ghost' do
    it_should_behave_like 'an state machine event', :ghost, 'open', 'ghosted'
  end

  describe '#close' do
    it_should_behave_like 'an state machine event', :close, 'ghosted', 'closed'
  end

  describe '#reset' do
    it_should_behave_like 'an state machine event', :reset, 'ghosted', 'open'
  end

  describe '#reopen' do
    it_should_behave_like 'an state machine event', :reopen, 'closed', 'open'
  end

  describe '#sign_proposal(user_id)' do
    context 'when user can sign' do
      before(:each) { negotiation.stub(:gatekeeper).with(composer_id,:sign).and_return(true) }

      it 'triggers proposal sign event' do
        expect(negotiation.proposal).to receive :sign
        negotiation.sign_proposal(composer_id)
      end

      it 'returns true' do
        expect(negotiation.sign_proposal(composer_id)).to eq true
      end
    end

    context 'when user cannot sign' do
      before(:each) { negotiation.stub(:gatekeeper).with(composer_id,:sign).and_return(false) }

      it 'returns false' do
        expect(negotiation.sign_proposal(composer_id)).to eq false
      end
    end
  end

  describe '#confirm_proposal(user_id)' do
    context 'when user can confirm' do
      before(:each) do
        negotiation.proposal.state = 'signed'
        negotiation.stub(:gatekeeper).with(composer_id,:confirm).and_return(true)
      end

      it 'triggers proposal confirm event' do
        expect(negotiation.proposal).to receive :confirm
        negotiation.confirm_proposal(composer_id)
      end

      it 'returns true' do
        expect(negotiation.confirm_proposal(composer_id)).to eq true
      end
    end

    context 'when user cannot confirm' do
      before(:each) { negotiation.stub(:gatekeeper).with(composer_id,:confirm).and_return(false) }

      it 'returns false' do
        expect(negotiation.confirm_proposal(composer_id)).to eq false
      end
    end
  end

  describe '#break_proposal' do
    it 'returns the result of triggering proposal.break' do
      negotiation.proposal.state_machine.stub(:trigger).with(:break).and_return('test')
      expect(negotiation.break_proposal).to eq negotiation.proposal.break
    end
  end

  describe '#reset_proposal' do
    it 'returns the result of triggering proposal.reset' do
      negotiation.proposal.state_machine.stub(:trigger).with(:reset).and_return('test')
      expect(negotiation.reset_proposal).to eq negotiation.proposal.reset
    end
  end

  describe '#ghost_proposal' do
    it 'returns the result of triggering proposal.ghost' do
      negotiation.proposal.state_machine.stub(:trigger).with(:ghost).and_return('test')
      expect(negotiation.ghost_proposal).to eq negotiation.proposal.ghost
    end
  end

  describe '#discard_proposal' do
    it 'returns the result of triggering proposal.discard' do
      negotiation.proposal.state_machine.stub(:trigger).with(:discard).and_return('test')
      expect(negotiation.discard_proposal).to eq negotiation.proposal.discard
    end
  end

  describe '#gatekeeper(user_id, action)' do
    context 'negotiation is not open' do
      before { negotiation.state = 'ghosted'}

      it 'returns false' do
        expect(negotiation.gatekeeper(composer_id,:sign)).to eq false
      end
    end

    context 'negotiation is open' do
      context 'user belongs to negotiation' do
        context 'action is :sign' do
          it 'returns false if user has money' do
            expect(negotiation_receiver_cash.gatekeeper(receiver_id,:sign)).to eq false
          end

          it 'returns true if user has no money' do
            expect(negotiation_receiver_cash.gatekeeper(composer_id,:sign)).to eq true
          end
        end

        context 'action is :confirm' do
          it 'returns true if user has money' do
            expect(negotiation_receiver_cash.gatekeeper(receiver_id,:confirm)).to eq true
          end

          it 'returns false if user has no money' do
            expect(negotiation_receiver_cash.gatekeeper(composer_id,:confirm)).to eq false
          end
        end

        context 'action is not :sign or :confirm' do
          it 'returns true' do
            expect(negotiation.gatekeeper(composer_id,:action)).to eq true
          end
        end
      end

      context 'user does not belong to negotiation' do
        it 'returns false' do
          expect(negotiation.gatekeeper('0',:sign)).to eq false
        end
      end
    end
  end

  describe '#proposal' do
    it 'returns the last proposal' do
      negotiation.proposals.build
      expect(negotiation.proposal).to eq negotiation.proposals.last
    end
  end

  describe '#money_owner?' do
    context 'when last proposal has money' do
      it 'returns true if user owns the money' do
        expect(negotiation_composer_cash.money_owner?(composer_id)).to eq true
      end

      it 'returns false if user does not own the money' do
        expect(negotiation_composer_cash.money_owner?(receiver_id)).to eq false
      end
    end

    context 'when last proposal does not have money' do
      it 'returns false' do
        expect(negotiation.money_owner?(composer_id)).to eq false
      end
    end
  end

  # Factories
  specify { expect(Fabricate.build(:negotiation)).to be_valid }
end
