require 'spec_helper'

describe Negotiation do

  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:composer_id) { negotiation.proposals.last.composer_id }
  let(:receiver_id) { negotiation.proposals.last.receiver_id }
  
  let(:negotiation_composer_cash) do
    negotiation.proposal.goods<<Fabricate.build(:cash,owner_id:composer_id)
  end
  
  let(:negotiation_receiver_cash) do
    negotiation.proposal.goods<<Fabricate.build(:cash,owner_id:receiver_id)
  end
 
  # Relations
  it { should have_and_belong_to_many :_users }
  it { should embed_many :proposals }
  it { should embed_many :messages }
  it { should_not embed_many :user_sheets }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:state).with_default_value('open') }

  # Validations
  it { should_not validate_presence_of :_users }
  it { should validate_presence_of :proposals }
  it { should_not validate_presence_of :messages }
  it { should validate_inclusion_of(:state).to_allow('open','successful','ghosted','closed') }


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

shared_examples 'an state machine event' do |action,initial_state,final_state|
    before(:each) { negotiation.state= initial_state }
    it "calls state_machine.trigger(#{action})" do
      expect(negotiation.proposal.state_machine).to receive(:trigger).with(action)
      negotiation.send(action)
    end

    it "changes proposal state from #{initial_state} to #{final_state}" do
      expect{negotiation.send(action)}.to change {negotiation.state}.from(initial_state).to(final_state)
    end

    it 'do not saves the proposal' do
      negotiation.send(action)
      expect(negotiation).to_not be_persisted
    end
  end

  describe '#success' do
    it_should_behave_like 'an state machine event', :success,'open','successful'
  end

  describe '#ghost' do
    it_should_behave_like 'an state machine event', :ghost,'open','ghosted'
  end
 
  describe '#close' do
    it_should_behave_like 'an state machine event', :discard,'ghosted','closed'
  end

  describe '#reset' do
    it_should_behave_like 'an state machine event', :reset,'ghosted','open'
  end

  describe '#reopen' do
    it_should_behave_like 'an state machine event', :reset,'closed','open'
  end

  describe '#gatekeeper(action,user)' do
    context 'negotiation is not being traded' do
      before { negotiation.state='ghosted'}      
      it 'returns false' do
        expect(negotiation.gatekeeper(composer_id,:sign)).to eq false
      end
    end

    context 'negotiation is being traded' do
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
  
  shared_examples 'gatekeeper check' do |method|
    it 'returns false if gatekeeper disagree' do
      negotiation.stub(:gatekeeper).and_return(false)
      expect(negotiation.send(method,composer_id)).to eq false
    end
  end

  shared_examples 'is a wrapper' do |method,wrapped_method|
    it "calls negotiation.proposal.#{wrapped_method}" do
      expect(negotiation.proposal).to receive(wrapped_method)
      negotiation.send(method)
    end
    it "returns negotiation.proposal.#{wrapped_method} result" do
      expect(negotiation.send(method)).to eq negotiation.proposal.send(wrapped_method) 
    end
  end

  describe '#sign_proposal(user)' do
    context 'gatekeeper agree' do
      before(:each) { negotiation.stub(:gatekeeper) { true } }
    end
    include_examples 'gatekeeper check',:sign_proposal
  end

  describe '#confirm_proposal(user)' do
    before(:each) { negotiation.proposal.state='signed'}
    include_examples 'gatekeeper check',:confirm_proposal
  end

  describe '#reject_proposal(user)' do
    before(:each) { negotiation.proposal.state='signed'}
    include_examples 'gatekeeper check',:reject_proposal
  end

  describe '#reset_proposal' do
    include_examples 'is a wrapper',:reset_proposal,:reset
  end

  describe '#suspend_proposal' do
    include_examples 'is a wrapper',:suspend_proposal,:suspend
  end

  describe '#discard_proposal' do
    include_examples 'is a wrapper',:discard_proposal,:discard
  end

  describe '#state_machine' do
    subject(:machine) { double().as_null_object }
    before(:each) { negotiation.state_machine(machine) }
    it { should have_received(:when).with(:success,'trading'=>'successful') }
    it { should have_received(:when).with(:fail,'trading'=>'failed') }
    it { should have_received(:when).with(:close,'failed'=>'closed' )}
    it { should have_received(:when).with(:trade,'closed'=>'trading') }
  end

  # Factories
  specify { expect(negotiation).to be_valid }
end