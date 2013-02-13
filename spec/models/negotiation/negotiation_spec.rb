require 'spec_helper'

describe Negotiation do
  let(:offer) do
    Fabricate(:offer)
  end
  let(:negotiation) do
    Fabricate.build(:negotiation, offer:offer)
  end

  describe 'Relations' do
    it { should embed_many(:proposals).of_type(Negotiation::Proposal) }
    it { should embed_many(:messages).of_type(Negotiation::Message) }
    it { should have_and_belong_to_many(:users) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
    it { should validate_presence_of :users }
  end

  describe 'Factories' do
    specify { expect(negotiation.valid?).to be_true, "Is not valid because #{negotiation.errors}" }
    specify { expect(negotiation.save).to be_true }

    it 'Creates one offer' do
      expect { negotiation.save }.to change{ Offer.count }.by(1)
    end

    it 'Creates two different users' do
      expect { negotiation.save }.to change{ User.count }.by(2)
    end
  end

  let(:new_negotiation) { Negotiation.open(offer).publish }

  describe '.open' do

    it 'generates a valid negotiation given an offer' do
      Negotiation.open(offer).should be_valid
    end

    it 'throws an exception given an invalid offer' do
      offer.should_receive(:valid?).and_return(:false)
      Negotiation.open(offer).should raise_error
      pending 'Choose wich exception to throw'
    end

    specify { new_negotiation.users.should include(offer.user_composer,offer.user_receiver) }
  end

  describe '#make_new_proposal(hash)' do
    xit 'Generates a new proposal with the given hash and post it into the negotiation'
  end

  describe '#part(user)' do
    xit 'Makes the given user to leave the negotiation'
    # ¿Podríamos conseguir que se ejecutara siempre desde el current_user sin pasarle ningun parametro?
    # entonces quedaria como #user_part.
  end

  xit 'Un metodo para aceptar la propuesta actual'
  xit 'Un metodo para rechazar la propuesta actual'
  xit 'Un metodo para comprobar el estado de aceptacion de la propuesta actual'




=begin
  # Funciones PUBLICAS necesarias (debatidas en el fuego de campamento)

  start_with(offer)      -> Inicia una negociación con la oferta recibida
  kick(user)             -> elimina el usuario (que viene en el hash) de la negociacion
  do_new_proposal(hash)  -> actualiza la propuesta actual (añadiendo otra)
  post_message(hash)     -> publica un nuevo mensage en la negociacion
  can_propose?(user)     -> pregunta si el usuario puede proposer cerrar la negociacion
  propose_deal(user)     -> el usuario propone cerrar el trato
  can_close?(user)       -> pregunta si el usuario puede cerrar la negociacion
  make_deal              -> crea un trato con la negociacion actual
  self_update            -> actualiza la propia negociacion



  kick
  .generate(hash)    -> crea una negotiation con los datos de un hash
  open               -> salva la negotiation

  update_proposal    ->
  post_message

  propose_deal(hash) -> el usuario del hash propone crear un trato
  #NOTA: el estado de cada usuario lo sacaríamos con un helper.
         cuando un usuario tiene el boton para proponer un trato
         se ejecutaria propose_deal(hash) y actualizaria lo necesario.
         al otro usuario entonces le saldria un boton aceptar el cual le llevaria
         al controlador de deal así que no es necesario ningun accept_deal

=end
end
