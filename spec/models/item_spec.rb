require 'spec_helper'

describe Item do
  let(:item) { Fabricate.build(:item) }

  # Modules
  it { should include_module Attachment::Images }

  # Relations
  it { should belong_to :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :name, :description }
  it { should have_field(:state).with_default_value_of('on_sale') }
  it { should have_field(:discarded).of_type(Boolean).with_default_value_of(false) }

  # Validations
  it { should validate_presence_of :user }
  it { should_not have_autosave_on :user }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_inclusion_of(:state).to_allow('on_sale','withdrawn','sold') }
  it { should validate_presence_of :discarded }

  # Methods
  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }
    before(:each) { item.state_machine(machine) }

    it { should have_received(:when).with(:withdraw, 'on_sale' => 'withdrawn') }
    it { should have_received(:when).with(:sell, 'on_sale' => 'sold') }
  end

  shared_examples 'an state machine event' do |action, initial_state, final_state|
    before(:each) { item.state = initial_state }

    it "calls state_machine.trigger(#{action})" do
      expect(item.state_machine).to receive(:trigger).with(action)
      item.send(action)
    end

    it "changes item state from #{initial_state} to #{final_state}" do
      expect{ item.send(action) }.to change { item.state }.from(initial_state).to(final_state)
    end

    it 'does not save the item' do
      item.send(action)
      expect(item).to_not be_persisted
    end
  end

  describe '#withdraw' do
    it_should_behave_like 'an state machine event', :withdraw, 'on_sale', 'withdrawn'
  end

  describe '#sell' do
    it_should_behave_like 'an state machine event', :sell, 'on_sale', 'sold'
  end

  describe '#discarded?' do
    pending "#discarded?"
  end

  describe '#discard' do
    context 'when item is discarded' do
      before(:each) { item.discarded = true }

      it 'does not change item discarded field' do
        expect{ item.discard }.to_not change{ item.discarded }
      end

      it 'returns false' do
        expect(item.discard).to eq false
      end
    end

    context 'when item is undiscarded' do
      before(:each) { item.discarded = false }

      it 'changes item discarded field to true' do
        expect{ item.discard }.to change{ item.discarded }.from(false).to(true)
      end

      it 'returns true' do
        expect(item.discard).to eq true
      end
    end
  end

  # Factories
  specify { expect(Fabricate.build(:item)).to be_valid }
end
