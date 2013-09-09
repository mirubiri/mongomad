require 'spec_helper'

describe Offer do
  # let(:user_composer) { Fabricate(:user_with_things) }
  # let(:user_receiver) { Fabricate(:user_with_things) }
  # let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:offer) { Fabricate.build(:offer) }

  # Relations
  it { should belong_to(:user_sender).of_type(User) }
  it { should belong_to(:user_receiver).of_type(User) }
  it { should embed_one :proposal }
  it { should embed_many :user_sheets } # ¿embed_one?

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :message }

  # Validations
  it { should validate_presence_of :user_sender }
  it { should validate_presence_of :user_receiver }
  it { should validate_presence_of :proposal }
  it { should validate_presence_of :message }
  it { should validate_length_of(:message).within(1..160) }
  it 'should validate presence of user_sheets for both users'

  #Methods
  describe '#sender' do
    it 'returns the sender user sheet' do
      expect(offer.sender).to eq offer.user_sheets.find(offer.user_sender_id)
    end
  end

  describe '#receiver' do
    it 'returns the receiver user sheet' do
      expect(offer.receiver).to eq offer.user_sheets.find(offer.user_receiver_id)
    end
  end

  describe '#negotiate' do
    it 'starts a negotiation with this offer as initial proposal' do
      expect(Negotiation).to receive(:create).with(users:[offer.user_sender,offer.user_receiver],proposal: offer.proposal,user_sheets: offer.user_sheets )
      offer=Fabricate(:offer) # Esta asi por que la fabrica de ofertas no guarda los items con .save si no se usa Fabricate() en el let()
      offer.negotiate
    end
    it 'returns false when offer is not saved' do
      expect(offer.negotiate).to eq false
    end

    it 'returns false when a product is not available' do
     pending 'Este para cuando se solucione el asunto de los items que no se guardan'
    end
  end

  # Factories
  specify { expect(Fabricate.build(:offer)).to be_valid }
end

