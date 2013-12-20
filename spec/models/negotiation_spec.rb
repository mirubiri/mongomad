require 'spec_helper'

describe Negotiation do

  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:composer_id) { negotiation.proposals.last.composer_id }
  let(:receiver_id) { negotiation.proposals.last.receiver_id }

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
  it { should validate_presence_of :state }

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
      expect(proposal.state_machine).to receive(:trigger).with(action)
      negotiation.send(action)
    end

    it "changes proposal state from #{initial_state} to #{final_state}" do
      expect {negotiation.send(action)}.to change {negotiation.state}.from(initial_state).to(final_state)
    end

    it 'do not saves the proposal' do
      negotiation.send(action)
      expect(negotiation).to_not be_persisted
    end
  end

  describe '#success' do
    it_should_behave_like 'an state machine event', :sucess,'trading','successful'
  end

  describe '#fail' do
    it_should_behave_like 'an state machine event', :fail,'trading','failed'
  end

  describe '#close' do
    it_should_behave_like 'an state machine event', :close,'failed','closed'
  end

  describe '#trade' do
    it_should_behave_like 'an state machine event', :trade,'closed','trading'
  end
  
  
  describe '#state_machine' do
    subject(:machine) { double().as_null_object }
    before(:each) { negotiation.state_machine(machine) }
    it { should have_received(:when).with(:success,'trading'=>'successful') }
    it { should have_received(:when).with(:fail,'trading'=>'failed') }
    it { should have_received(:when).with(:close,'failed'=>'closed' }
    it { should have_received(:when).with(:trade,'closed'=>'trading') }
  end

  # Factories
  specify { expect(negotiation).to be_valid }
end