require 'spec_helper'

describe Offer do
  # Variables
  let(:offer) { Fabricate.build(:offer) }

  # Relations
  it { should belong_to(:user_composer).of_type(User).as_inverse_of(:sent_offers) }
  it { should belong_to(:user_receiver).of_type(User).as_inverse_of(:received_offers) }
  it { should belong_to :negotiation }
  it { should embed_many :user_sheets }
  it { should embed_one :proposal }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :message }
  it { should have_field(:state).with_default_value_of('new') }

  # Validations
  it { should validate_presence_of :user_composer }
  it { should_not have_autosave_on :user_composer }
  it { should validate_presence_of :user_receiver }
  it { should_not have_autosave_on :user_receiver }
  it { should_not validate_presence_of :negotiation }
  it { should validate_presence_of :user_sheets }
  it { should validate_presence_of :proposal }
  it { should validate_length_of(:message).within(1..160) }
  it { should validate_inclusion_of(:state).to_allow('new','negotiating','negotiated','ghosted','discarded') }

  it 'is invalid when there is no sheet for user_composer' do
    offer.user_composer_id = nil
    expect(offer).to have(1).error_on(:user_sheets)
  end

  it 'is invalid when there is no sheet for user_receiver' do
    offer.user_receiver_id = nil
    expect(offer).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there are more than two user sheets' do
    offer.user_sheets << Fabricate.build(:user_sheet)
    expect(offer).to have(1).error_on(:user_sheets)
  end

  # Methods
  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }

    before(:each) { offer.state_machine(machine) }

    it { should have_received(:when).with(:negotiate, 'new' => 'negotiating',
                                                      'negotiated' => 'negotiating') }

    it { should have_received(:when).with(:negotiated, 'negotiating' => 'negotiated') }

    it { should have_received(:when).with(:ghost, 'new' => 'ghosted',
                                                  'negotiating' => 'ghosted',
                                                  'negotiated' => 'ghosted') }

    it { should have_received(:when).with(:discard, 'ghosted' => 'discarded') }
  end

  shared_examples 'an state machine event' do |action, initial_state, final_state|
    before(:each) { offer.state = initial_state }

    it "calls state_machine.trigger(#{action})" do
      expect(offer.state_machine).to receive(:trigger).with(action)
      offer.send(action)
    end

    it "changes offer state from #{initial_state} to #{final_state}" do
      expect{ offer.send(action) }.to change { offer.state }.from(initial_state).to(final_state)
    end

    it 'does not save the offer' do
      offer.send(action)
      expect(offer).to_not be_persisted
    end
  end

  describe '#negotiate' do
    it_should_behave_like 'an state machine event', :negotiate, 'new', 'negotiating'
  end

  describe '#negotiated' do
    it_should_behave_like 'an state machine event', :negotiated, 'negotiating', 'negotiated'
  end

  describe '#ghost' do
    it_should_behave_like 'an state machine event', :ghost, 'negotiating', 'ghosted'
  end

  describe '#discard' do
    it_should_behave_like 'an state machine event', :discard, 'ghosted', 'discarded'
  end

  describe '#composer' do
    it 'returns the composer user sheet' do
      expect(offer.composer).to eq offer.user_sheets.find(offer.user_composer_id)
    end
  end

  describe '#receiver' do
    it 'returns the receiver user sheet' do
      expect(offer.receiver).to eq offer.user_sheets.find(offer.user_receiver_id)
    end
  end

  # Factories
  specify { expect(Fabricate.build(:offer)).to be_valid }
end
