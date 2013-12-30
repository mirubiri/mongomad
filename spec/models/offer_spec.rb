require 'spec_helper'

describe Offer do

  let(:offer) { Fabricate.build(:offer) }

  # Relations
  it { should belong_to(:user_composer).of_type(User).as_inverse_of(:sent_offers) }
  it { should belong_to(:user_receiver).of_type(User).as_inverse_of(:received_offers) }
  it { should embed_one :proposal }
  it { should_not embed_many :user_sheets }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :message }

  # Validations
  it { should validate_presence_of :user_composer }
  it { should validate_presence_of :user_receiver }
  it { should validate_presence_of :proposal }
  it { should validate_presence_of :message }
  it { should validate_length_of(:message).within(1..160) }


  #Methods
  describe '#composer' do
    it 'returns the composer user sheet' do
      expect(offer.composer).to eq offer.proposal.user_sheets.find(offer.user_composer_id)
    end
  end

  describe '#receiver' do
    it 'returns the receiver user sheet' do
      expect(offer.receiver).to eq offer.proposal.user_sheets.find(offer.user_receiver_id)
    end
  end

  describe '#negotiate' do
    it 'starts a negotiation with this offer as initial proposal' do
      offer.save
      expect(Negotiation).to receive(:create).with(_users:[offer.user_composer,offer.user_receiver], proposals:[offer.proposal])
      offer.negotiate
    end

    it 'returns a negotiation' do
      offer.save
      expect(offer.negotiate).to be_an_instance_of(Negotiation)
    end

    it 'returns a valid negotiation' do
      offer.save
      expect(offer.negotiate).to be_valid
    end

    it 'returns false when offer is not saved' do
      expect(offer.negotiate).to eq false
    end

    it 'returns false when a item is not available' do
      pending 'Este para cuando se solucione el asunto de los items que no se guardan'
    end
  end

  # Factories
  specify { expect(Fabricate.build(:offer)).to be_valid }
end

