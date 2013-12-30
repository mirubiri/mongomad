require 'spec_helper'

describe Product do

  let(:item) { Fabricate(:item) }
  let(:product) { Fabricate.build(:product,item:item) }

  # Relations
  it { should be_embedded_in :proposal }
  specify { Product.should < Good }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :name,:description }
  it { should have_field(:quantity).of_type(Integer) }
  it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:state).with_default_value_of('available') }

  # Validations
  it { should_not validate_presence_of :proposal }
  it { should validate_numericality_of(:quantity).to_allow(nil: false, only_integer: true, greater_than_or_equal_to: 0) }
  it { should validate_inclusion_of(:state).to_allow('available', 'unavailable', 'ghosted', 'discarded') }

  # Methods
 shared_examples 'an state machine event' do |action, initial_state, final_state|
    before(:each) { item.state = initial_state }
    
    it "calls state_machine.trigger(#{action})" do
      expect(item.state_machine).to receive(:trigger).with(action)
      item.send(action)
    end

    it "changes item state from #{initial_state} to #{final_state}" do
      expect {item.send(action)}.to change {item.state}.from(initial_state).to(final_state)
    end

    it 'do not saves the item' do
      item.send(action)
      expect(item).to_not be_persisted
    end
  end

  #TODO: REVISAR LOS NOMBRES (available, unavailable)
  describe '#available' do
    it_should_behave_like 'an state machine event', :available, 'available', 'unavailable'
  end

  describe '#unavailable' do
    it_should_behave_like 'an state machine event', :unavailable, 'unavailable', 'available'
  end

  describe '#ghost' do
    it_should_behave_like 'an state machine event', :ghost, 'available', 'ghosted'
  end
 
  describe '#discard' do
    it_should_behave_like 'an state machine event', :discard, 'ghosted', 'discarded'
  end

  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }

    before(:each) { proposal.state_machine(machine) }

    it { should have_received(:when).with(:available, 'available' => 'unavailable') }

    it { should have_received(:when).with(:unavailable, 'unavailable' => 'available') }

    it { should have_received(:when).with(:ghost, 'available' => 'ghosted',                                               
                                                  'unavailable' => 'ghosted') } 

    it { should have_received(:when).with(:discard, 'ghosted' => 'discarded') }
  end
  
  specify '.new' do
    expect(Product.new.id).to eq nil
  end

  describe '#item' do
    it 'return the item corresponding to product id' do
      expect(product.item).to eq item
    end
  end

  describe '#sell' do
    it 'calls to product.item' do
      expect(product).to receive(:item).and_call_original
      product.sell
    end

    it 'calls to item.sell with product.quantity' do
      expect_any_instance_of(Item).to receive(:sell).with(product.quantity)
      product.sell
    end
  end

  describe '#available?' do
    it 'calls to product.item' do
      expect(product).to receive(:item).and_call_original
      product.available?
    end

    it 'calls to item.available? with product.quantity' do
      expect_any_instance_of(Item).to receive(:available?).with(product.quantity)
      product.available?
    end
  end

  # Factories
  specify { expect(Fabricate.build(:product)).to be_valid }
end
