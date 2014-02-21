require 'spec_helper'

describe Product do
  let(:item) { Fabricate(:item) }
  let(:product) { Fabricate.build(:product, item:item) }

  # Modules
  it { should include_module AutoUpdate }

  # Relations
  specify { Product.should < Good }

  # Attributes
  it { should have_field(:_id).of_type(Moped::BSON::ObjectId) }
  it { should have_fields :name, :description }
  it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:state).with_default_value_of('on_sale') }
  it { should auto_update(:name, :description, :images).using :item }

  # Validations
  it { should validate_presence_of :_id }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :owner_id }
  it { should validate_inclusion_of(:state).to_allow('on_sale','withdrawn','sold') }

  # Methods
  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }
    before(:each) { product.state_machine(machine) }

    it { should have_received(:when).with(:withdraw, 'on_sale' => 'withdrawn') }
    it { should have_received(:when).with(:sell, 'on_sale' => 'sold') }
  end

  shared_examples 'an state machine event' do |action, initial_state, final_state|
    before(:each) { product.state = initial_state }

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
  end

  describe '#withdraw' do
    it_should_behave_like 'an state machine event', :withdraw, 'on_sale', 'withdrawn'
  end

  describe '#sell' do
    it_should_behave_like 'an state machine event', :sell, 'on_sale', 'sold'
  end

  specify '.new' do
    expect(Product.new._id).to eq nil
  end

  describe '#item' do
    it 'returns the item corresponding to product._id' do
      expect(product.item).to eq item
    end
  end

  # Factories
  specify { expect(Fabricate.build(:product)).to be_valid }
end
