require 'spec_helper'

describe User do
  let(:user) do
    Fabricate.build(:user)
  end

  describe 'Relations' do
    it { should embed_one(:profile).of_type(User::Profile) }
    it { should embed_many(:things).of_type(User::Thing) }
    it { should have_many(:requests) }
    it { should have_many(:sent_offers).of_type(Offer) }
    it { should have_many(:received_offers).of_type(Offer) }
    it { should have_and_belong_to_many(:negotiations) }
    it { should have_and_belong_to_many(:deals) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :profile }
  end

  describe 'Factories' do
    specify { expect(user.valid?).to be_true, "Is not valid because #{user.errors}" }
    specify { expect(user.save).to be_true }
  end

=begin
  # Funciones PUBLICAS necesarias (debatidas en el fuego de campamento)

  # FUNCIONES DEL USUARIO
  change_password    -> cambio de contraseña
  change_email       -> cambio de email
  close_account      -> cierra la cuenta del usuario

  # FUNCIONES DE LAS COSAS
  add_thing(hash)    -> añade una cosa al usuario con los datos del hash
  remove_thing(hash) -> elimina la cosa del usuario
=end
end
