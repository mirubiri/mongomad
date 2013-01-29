require 'spec_helper'

describe Offer do
  let(:offer) do
    Fabricate.build(:offer)
  end

  describe 'Relations' do
    it { should embed_one(:composer).of_type(Offer::Composer) }
    it { should embed_one(:receiver).of_type(Offer::Receiver) }
    it { should embed_one(:money).of_type(Offer::Money) }
    it { should belong_to(:user_composer).of_type(User) }
    it { should belong_to(:user_receiver).of_type(User) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:initial_message).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :user_composer }
    it { should validate_presence_of :user_receiver }
    it { should validate_presence_of :initial_message }
  end

  describe 'Factories' do
    specify { expect(offer.valid?).to be_true, "Is not valid because #{offer.errors}" }
    specify { expect(offer.save).to be_true }

    it 'Creates two different users' do
      expect { offer.save }.to change{ User.count }.by(2)
      offer.user_composer.should_not eq offer.user_receiver
    end
  end

=begin # estamos arreglando el destrodo este  :P

NO SE COMO HACER UN HASH PARA PROBAR
¿lo hago a pelo rellenando los campos con una oferta que me creo?
¿lo tengo que pillar de algun lado?

  describe '#generate_from(hash)' do
    it { should respond_to(:generate_from).with(1).arguments }

    # specify { offer.generate_from() }
    # comprobar que es de tipo Offer
    #specify { thing.to_offer_composer_product(1).should be_kind_of(Offer::Composer::Product) }

    it 'Generates a new offer with the given hash' do
      aux_offer = Fabricate(:offer)
      offer_hash = {
        "user_composer_id" => aux_offer.user_composer_id,
        "user_receiver_id" => aux_offer.user_receiver_id,
        "composer_things" => {
          "" => "",
          "" => "",
          "" => "",
        },
        "receiver_things" => {
          "" => "",
          "" => "",
          "" => "",
        },
        "money" => {
          "user_id" => "",
          "quantity" => "",
        },
        "initial_message" => ""
      }

    end

  end
=end

  describe '#open_negotiation' do
    xit 'Opens a new negotiation for this offer'
  end
end
