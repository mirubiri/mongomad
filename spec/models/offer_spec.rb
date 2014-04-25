require 'spec_helper'

describe Offer do

  let(:composer) { Fabricate.build(:user) }
  let(:receiver) { Fabricate.build(:user) }
  let(:proposal) do
    Proposal.new
    proposal.composer_id=composer.id
    proposal.receiver_id=receiver.id
  end
  let(:composer_sheet) { composer.sheet }
  let(:receiver_sheet) { receiver.sheet }
  let(:offer) { Offer.new }

  # Relations
  it { should have_and_belong_to_many(:users) }
  it { should belong_to :negotiation }
  it { should embed_one :proposal }
  it { should embed_many(:user_sheets).of_type(UserSheet) }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :message }

  # Methods
  it { should_not respond_to(:users,:proposal,:proposal=,:user_sheets,:user_ids) }

  describe '#add_participant' do
    it 'adds a participant' do
      offer.add_participant(composer)
      expect(offer.composer).to eq composer_sheet
    end
  end


  describe '#composer' do
    it 'returns the composer sheet if composer was set' do
      offer.composer=composer
      expect(offer.composer).to eq composer_sheet
    end

    it 'returns nil' do
      expect(offer.composer).to eq nil
    end
  end

  describe '#receiver' do
    it 'returns the receiver sheet if composer was set' do
      offer.receiver=receiver
      expect(proposal.receiver).to eq receiver_sheet
    end

    it 'returns nil if receiver is not set' do
      expect(offer.receiver).to eq nil
    end
  end

  describe '#negotiate' do
    describe 'returned negotiation' do
      it 'includes composer as participant' do
        expect(negotiate.composer).to eq offer.composer
      end

      it 'includes receiver as participant' do
        expect(negotiation.receiver).to eq offer.receiver
      end

      it 'includes the proposal in offer' do

      end
    end
  end

  # Factories
end
