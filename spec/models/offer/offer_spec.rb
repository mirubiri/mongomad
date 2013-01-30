require 'spec_helper'

describe Offer do
  let(:offer) do
    Fabricate.build(:offer)
  end

  let(:offer_hash) do {
    user_composer_id: offer.user_composer_id,
    user_receiver_id: offer.user_receiver_id,
    composer_things:  offer.composer.products.inject({}) do |hash, product|
                        hash.merge({ product[:thing_id] => product[:quantity] })
                      end,
    receiver_things:  offer.receiver.products.inject({}) do |hash, product|
                        hash.merge({ product[:thing_id] => product[:quantity] })
                      end,
    money:            { offer.money.user_id => offer.money.quantity },
    initial_message:  offer.initial_message
    }
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

  describe '.generate_from(hash)' do
    it { should respond_to(:generate_from).with(1).arguments }

    it 'Generates a new offer with the given hash' do
      offer.save
      new_offer = Offer.generate_from(offer_hash)
      new_offer.user_composer_id eql offer_hash[:user_composer_id]
      new_offer.user_receiver_id eql offer_hash[:user_receiver_id]
      new_offer.composer.products.size eql offer_hash[:composer_things].length
      new_offer.composer.products.each do |product|
        product.quantity eql offer_hash[product.thing_id.to_sym]
      end
      new_offer.receiver.products.size eql offer_hash[:receiver_things].length
      new_offer.receiver.products.each do |product|
        product.quantity eql offer_hash[product.thing_id.to_sym]
      end
      new_offer.money.user_id eql offer_hash[:money].keys.first
      new_offer.money.quantity eql offer_hash[:money].values.first
      new_offer.initial_message eql offer_hash[:initial_message]
    end

    it 'Cannot generate an offer with an invalid user composer id' do
    end
    it 'Cannot generate an offer with an invalid user receiver id' do
    end
    it 'Cannot generate an offer without composer money or products' do
    end
    it 'Cannot generate an offer without receiver money or products' do
    end
    it 'Cannot generate an offer with no money owner and money quantity greater than 0' do
    end
    it 'Cannot generate an offer with an invalid initial message' do
    end


=begin


=end


    end
  end

=begin # estamos arreglando el destrodo este  :P


Metodos y validaciones oferta:
- generar oferta desde hash
  *  comporbar que responde al metodo con los parametros q sean
- empezar negociacion desde oferta
  *  comporbar que responde al metodo con los parametros q sean





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
