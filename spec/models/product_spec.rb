require 'spec_helper'

describe Product do
  # Variables
  let(:item) { Fabricate.build(:item) }
  let(:product) { item.product }

  # Modules
  it { should include_module AutoUpdate }

  # Relations
  specify { Product.should < Good }

  # Attributes
  it { should have_field(:_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }
  it { should have_fields :name, :description }
  it { should have_field(:state).with_default_value_of('on_sale') }
  it { should auto_update(:name, :description, :images).using :item }

  # Validations
  it { should validate_presence_of :_id }
  it { should validate_presence_of :owner_id }
  it { should validate_length_of(:name).within(1..20) }
  it { should validate_length_of(:description).within(1..200) }
  it { should validate_inclusion_of(:state).to_allow('on_sale','withdrawn','sold') }

  # Methods
  specify '.new' do
    expect(Product.new.id).to eq nil
  end

  describe '#item' do
    before(:each) { item.save }

    it 'returns the item corresponding to product.id' do
      expect(product.item).to eq item
    end
  end

  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }
    before(:each) { product.state_machine(machine) }

    it { should have_received(:when).with(:withdraw, 'on_sale' => 'withdrawn') }
    it { should have_received(:when).with(:sell, 'on_sale' => 'sold') }
  end

  shared_examples 'valid state machine event' do |action, initial_state, final_state|
    before(:each) { product.state = initial_state }
    let(:test_code) { "random_test_code:#{Faker::Number.number(8)}" }

    it "calls state_machine.trigger(#{action})" do
      expect(product.state_machine).to receive(:trigger).with(action)
      product.send(action)
    end

    it "changes product state from #{initial_state} to #{final_state}" do
      expect{ product.send(action) }.to change { product.state }.from(initial_state).to(final_state)
    end

    it 'does not save the product' do
      product.send(action)
      expect(product).to_not be_persisted
    end

    it "returns the result of calling state_machine.trigger(#{action})" do
      product.state_machine.stub(:trigger).with(action) { test_code }
      expect(product.send(action)).to eq test_code
    end
  end

  describe '#withdraw' do
    it_should_behave_like 'valid state machine event', :withdraw, 'on_sale', 'withdrawn'
  end

  describe '#sell' do
    it_should_behave_like 'valid state machine event', :sell, 'on_sale', 'sold'
  end

  # Factories
  specify { expect(Fabricate.build(:product)).to be_valid }
end
