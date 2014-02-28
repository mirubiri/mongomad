require 'spec_helper'

describe Offer do
  let(:user_composer) { Fabricate.build(:user_with_items) }
  let(:user_receiver) { Fabricate.build(:user_with_items) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }

  # Relations
  it { should belong_to(:user_composer).of_type(User).as_inverse_of(:sent_offers) }
  it { should belong_to(:user_receiver).of_type(User).as_inverse_of(:received_offers) }
  it { should belong_to :negotiation }
  it { should embed_many :user_sheets }
  it { should embed_one :proposal }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :message }
  it { should have_field(:state).with_default_value_of('on_sale') }
  it { should have_field(:discarded).of_type(Boolean).with_default_value_of(false) }
  it { should have_field(:negotiating).of_type(Boolean).with_default_value_of(false) }
  it { should have_field(:negotiated_times).of_type(Integer).with_default_value_of(0) }

  # Validations
  it { should validate_presence_of :user_composer }
  it { should_not have_autosave_on :user_composer }
  it { should validate_presence_of :user_receiver }
  it { should_not have_autosave_on :user_receiver }
  it { should_not validate_presence_of :negotiation }
  it { should validate_presence_of :user_sheets }
  it { should validate_presence_of :proposal }
  it { should validate_length_of(:message).within(1..160) }
  it { should validate_inclusion_of(:state).to_allow('on_sale','withdrawn','sold') }
  it { should validate_presence_of :discarded }
  it { should validate_presence_of :negotiating }
  it { should validate_numericality_of(:negotiated_times).greater_than_or_equal_to(0) }

  # Checks
  it 'is invalid if both users are the same' do
    offer.user_receiver = offer.user_composer
    expect(offer).to have(1).error_on(:users)
    expect(offer.errors_on(:users)).to include('Composer and receiver should not be equal.')
  end

  it 'is invalid if there are more than two user sheets' do
    offer.user_sheets << Fabricate.build(:user_sheet)
    expect(offer).to have(1).error_on(:user_sheets)
    expect(offer.errors_on(:user_sheets)).to include('Offer should have only two user_sheets.')
  end

  it 'is invalid if there is no sheet for composer' do
    offer.user_composer_id = nil
    expect(offer).to have(1).error_on(:user_sheets)
    expect(offer.errors_on(:user_sheets)).to include('Offer should have one user_sheet for composer.')
  end

  it 'is invalid if there is no sheet for receiver' do
    offer.user_receiver_id = nil
    expect(offer).to have(1).error_on(:user_sheets)
    expect(offer.errors_on(:user_sheets)).to include('Offer should have one user_sheet for receiver.')
  end

  it 'is invalid if proposal is not owned by both users' do
    offer.proposal = Fabricate.build(:proposal)
    expect(offer).to have(1).error_on(:proposal)
    expect(offer.errors_on(:proposal)).to include('Proposal should be owned by both users.')
  end

  # Methods
  describe '#composer' do
    let(:user_sheet) { user_composer.sheet }

    it 'returns the composer user sheet' do
      expect(offer.composer).to eq user_sheet
    end
  end

  describe '#receiver' do
    let(:user_sheet) { user_receiver.sheet }

    it 'returns the receiver user sheet' do
      expect(offer.receiver).to eq user_sheet
    end
  end

  describe '#state_machine(machine)' do
    subject(:machine) { double().as_null_object }
    before(:each) { offer.state_machine(machine) }

    it { should have_received(:when).with(:withdraw, 'on_sale' => 'withdrawn') }
    it { should have_received(:when).with(:sell, 'on_sale' => 'sold') }
  end

  shared_examples 'valid state machine event' do |action, initial_state, final_state|
    before(:each) { offer.state = initial_state }
    let(:test_code) { "random_test_code:#{Faker::Number.number(8)}" }

    it "calls state_machine.trigger(#{action})" do
      expect(offer.state_machine).to receive(:trigger).with(action)
      offer.send(action)
    end

    it "changes offer state from #{initial_state} to #{final_state}" do
      expect{ offer.send(action) }.to change { offer.state }.from(initial_state).to(final_state)
    end

    it 'changes offer discarded field to true' do
      expect{ offer.send(action) }.to change{ offer.discarded }.from(false).to(true)
    end

    it 'does not save the offer' do
      offer.send(action)
      expect(offer).to_not be_persisted
    end

    it "returns the result of calling state_machine.trigger(#{action})" do
      offer.state_machine.stub(:trigger).with(action) { test_code }
      expect(offer.send(action)).to eq test_code
    end
  end

  shared_examples 'invalid state machine event' do |action, initial_state, final_state|
    before(:each) { offer.state = initial_state }

    it "does not call state_machine.trigger(#{action})" do
      expect(offer.state_machine).to_not receive(:trigger).with(action)
      offer.send(action)
    end

    it "does not change offer state" do
      expect{ offer.send(action) }.to_not change { offer.state }
    end

    it 'does not change offer discarded field' do
      expect{ offer.send(action) }.to_not change{ offer.discarded }
    end

    it 'returns false' do
      expect(offer.send(action)).to eq false
    end
  end

  describe '#withdraw' do
    context 'when offer is discarded' do
      before(:each) { offer.discarded = true }
      it_should_behave_like 'invalid state machine event', :withdraw, 'on_sale', 'withdrawn'
    end

    context 'when offer is not discarded' do
      before(:each) { offer.discarded = false }
      it_should_behave_like 'valid state machine event', :withdraw, 'on_sale', 'withdrawn'
    end
  end

  describe '#sell' do
    context 'when offer is discarded' do
      before(:each) { offer.discarded = true }
      it_should_behave_like 'invalid state machine event', :sell, 'on_sale', 'sold'
    end

    context 'when offer is not discarded' do
      before(:each) { offer.discarded = false }
      it_should_behave_like 'valid state machine event', :sell, 'on_sale', 'sold'
    end
  end

  describe '#discarded?' do
    context 'when offer is discarded' do
      before(:each) { offer.discarded = true }

      it 'returns true' do
        expect(offer.discarded?).to eq true
      end
    end

    context 'when offer is undiscarded' do
      before(:each) { offer.discarded = false }

      it 'returns false' do
        expect(offer.discarded?).to eq false
      end
    end
  end

  describe '#discard' do
    context 'when offer is discarded' do
      before(:each) { offer.discarded = true }

      it 'does not change offer discarded field' do
        expect{ offer.discard }.to_not change{ offer.discarded }
      end

      it 'returns false' do
        expect(offer.discard).to eq false
      end
    end

    context 'when offer is undiscarded' do
      before(:each) { offer.discarded = false }

      it 'changes offer discarded field to true' do
        expect{ offer.discard }.to change{ offer.discarded }.from(false).to(true)
      end

      it 'returns true' do
        expect(offer.discard).to eq true
      end
    end
  end

  describe '#negotiating?' do
    context 'when offer is being negotiated' do
      before(:each) { offer.negotiating = true }

      it 'returns true' do
        expect(offer.negotiating?).to eq true
      end
    end

    context 'when offer is not being negotiated' do
      before(:each) { offer.negotiating = false }

      it 'returns false' do
        expect(offer.negotiating?).to eq false
      end
    end
  end

  describe '#negotiate' do
    context 'when offer is being negotiated' do
      pending 'dont create a new negotiation'
      pending 'dont change assotiation/check assotiation'
      pending 'dont change negotiating'
      pending 'dont change negotiated times'
      pending 'returns true'
    end
    context 'when offer is not being negotiated' do
      pending 'create a new negotiation'
      pending 'assotiate offer and negotiation'
      pending 'set negotiating to true'
      pending 'add 1 to negotiated times'
      pending 'returns true'
    end
  end

  # Factories
  specify { expect(Fabricate.build(:offer)).to be_valid }
end
