require 'spec_helper'

describe Negotiation do
  describe 'Relations' do
    it { should embed_many :proposals }
    it { should embed_many :messages }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:token_owner_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:token_state).of_type(Boolean) }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
    it { should validate_presence_of :token_owner_id }
    it { should validate_presence_of :token_state }
  end

  describe 'Factory' do
    let (:negotiation) { Fabricate(:negotiation) }
    specify { negotiation.should be_valid }
    specify { negotiation.save.should be_true }
  end

  xit '#send_proposal(proposal)'
  xit '#leave(participant)'
  xit '#join(participant)'
  xit '#write_message(participant,message)'
  xit '#accept_proposal(participant)'
  xit '#reject_proposal(participant)'
  xit '#make_deal'
  xit '#finish'
  xit '#date_started'
  xit '#current_proposal'
  xit '#historic_proposals'
  xit 'Una funcion para reiniciar el juego'
  xit '#participants'
  xit '#conversation'
  xit ''
end