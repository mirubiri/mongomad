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
  it { should have_field(:stock).of_type(Integer) }
  it { should have_field(:state).with_default_value_of('available') }

  # Validations
  it { should validate_presence_of :user }
  it { should validate_presence_of :stock }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_numericality_of(:stock).to_allow(nil: false, only_integer: true, greater_than_or_equal_to: 0) }
  it { should validate_inclusion_of(:state).to_allow('available', 'unavailable', 'ghosted', 'discarded') }

  # Factories
  specify { expect(Fabricate.build(:item)).to be_valid }

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

  describe '#pick(quantity)' do

    it 'returns a Product filled with item name, description,images and given quantity' do
      expect(Product).to receive(:new).with(name:item.name,description:item.description,images:item.images,quantity:1)
      item.pick(1)
    end

    specify { expect(item.pick(1).id).to eq item.id }
    specify { expect(item.pick(1).owner_id).to eq item.user.id }
  end

  describe '#sell(quantity)' do
    it 'removes the given quantity of items from the stock' do
      expect {item.sell(1)}.to change {item.stock}.by(-1)
    end
    it 'saves the change' do
      item.sell(1)
      expect(item).to be_persisted
    end

    context 'When given quantity is not available' do
      it 'returns false' do
        expect(item.sell(100)).to eq false
      end

      it 'does not change the stock attribute' do
        stock=item.stock
        item.sell(100)
        expect(item.stock).to eq stock
      end
    end
  end

  describe '#supply(quantity)' do
    it 're-stock this item with the given quantity' do
      expect {item.supply(1)}.to change {item.stock}.by(1)
    end
    it 'saves the change' do
      item.supply(1)
      expect(item).to be_persisted
    end
  end

  describe '#available?(quantity)' do
    it 'true if item has enough asked stock' do
      asked=item.stock-1
      expect(item.available?(asked)).to eq true
    end

    it 'false if item has not enough asked stock' do
      asked=item.stock+1
      expect(item.available?(asked)).to eq false
    end

    it 'false if stock is nil' do
      item.stock=nil
      expect(item.available?(1)).to eq false
    end

    it 'false if asked stock is 0' do
      expect(item.available?(0)).to eq false
    end
  end
end
