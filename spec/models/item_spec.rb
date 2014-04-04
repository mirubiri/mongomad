require 'spec_helper'

describe Item do
  # Variables
  let(:item) { Fabricate.build(:item) }

  # Modules
  it { should include_module Attachment::Images }

  # Relations
  it { should belong_to :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :name, :description }
  it { should have_field(:state).with_default_value_of('on_sale') }
  it { should have_field(:hidden).of_type(Boolean).with_default_value_of(false) }

  # Validations
  it { should validate_presence_of :user }
  it { should_not have_autosave_on :user }
  it { should validate_length_of(:name).within(1..20) }
  it { should validate_length_of(:description).within(1..200) }
  it { should validate_inclusion_of(:state).to_allow('on_sale','withdrawn','sold') }
  it { should validate_presence_of :hidden }

  # Methods
  describe '#to_product' do
    specify { expect(item.to_product.id).to eq item.id }
    specify { expect(item.to_product.owner_id).to eq item.user_id }

    it 'returns a Product filled with item data' do
      expect(Product).to receive(:new).with(name:item.name, description:item.description, owner_id:item.user_id, images:item.images)
      item.to_product
    end
  end

  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }
    before(:each) { item.state_machine(machine) }

    it { should have_received(:when).with(:withdraw, 'on_sale' => 'withdrawn') }
    it { should have_received(:when).with(:sell, 'on_sale' => 'sold') }
  end

  shared_examples 'valid state machine event' do |action, initial_state, final_state|
    before(:each) { item.state = initial_state }
    let(:test_code) { "random_test_code:#{Faker::Number.number(8)}" }

    it "calls state_machine.trigger(#{action})" do
      expect(item.state_machine).to receive(:trigger).with(action)
      item.send(action)
    end

    it "changes item state from #{initial_state} to #{final_state}" do
      expect { item.send(action) }.to change { item.state }.from(initial_state).to(final_state)
    end

    it 'does not save the item' do
      item.send(action)
      expect(item).to_not be_persisted
    end

    it "returns the result of calling state_machine.trigger(#{action})" do
      item.state_machine.stub(:trigger).with(action) { test_code }
      expect(item.send(action)).to eq test_code
    end
  end

  shared_examples 'invalid state machine event' do |action, initial_state, final_state|
    before(:each) { item.state = initial_state }

    it "does not call state_machine.trigger(#{action})" do
      expect(item.state_machine).to_not receive(:trigger).with(action)
      item.send(action)
    end

    it "does not change item state" do
      expect { item.send(action) }.to_not change { item.state }
    end

    it 'does not change item hidden field' do
      expect { item.send(action) }.to_not change { item.hidden }
    end

    it 'returns false' do
      expect(item.send(action)).to eq false
    end
  end

  describe '#withdraw' do
    context 'when item is hidden' do
      before(:each) { item.hidden = true }
      it_should_behave_like 'invalid state machine event', :withdraw, 'on_sale', 'withdrawn'
    end

    context 'when item is unhidden' do
      before(:each) { item.hidden = false }
      it_should_behave_like 'valid state machine event', :withdraw, 'on_sale', 'withdrawn'

      it 'changes item hidden field to true' do
        expect { item.withdraw }.to change { item.hidden }.from(false).to(true)
      end
    end
  end

  describe '#sell' do
    context 'when item is hidden' do
      before(:each) { item.hidden = true }
      it_should_behave_like 'invalid state machine event', :sell, 'on_sale', 'sold'
    end

    context 'when item is unhidden' do
      before(:each) { item.hidden = false }
      it_should_behave_like 'valid state machine event', :sell, 'on_sale', 'sold'

      it 'does not change item hidden field' do
        expect { item.sell }.to_not change { item.hidden }
      end
    end
  end

  describe '#hide' do
    context 'when item is hidden' do
      before(:each) { item.hidden = true }

      it 'does not change item hidden field' do
        expect { item.hide }.to_not change { item.hidden }
      end

      it 'returns false' do
        expect(item.hide).to eq false
      end
    end

    context 'when item is unhidden' do
      before(:each) { item.hidden = false }

      it 'changes item hidden field to true' do
        expect { item.hide }.to change { item.hidden }.from(false).to(true)
      end

      it 'returns true' do
        expect(item.hide).to eq true
      end
    end
  end

  # Factories
  specify { expect(Fabricate.build(:item)).to be_valid }
end
