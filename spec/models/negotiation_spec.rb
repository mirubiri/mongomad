require 'spec_helper'

describe Negotiation do
  let(:negotiation) { Fabricate(:negotiation) }

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
    specify { negotiation.should be_valid }
    specify { negotiation.save.should be_true }
  end

  describe '#other_id(id_negotiator)' do
    xit 'Returns the id of the other negotiator'
  end

  describe '#user_negotiator(id_negotiator)' do
    xit 'Returns negotiator with the given id'
  end

  describe '#make_proposal(proposal)' do
    xit 'Adds proposal to negotiation'
  end

  describe '#last_proposal' do
    xit 'Returns last proposal'
  end

  describe '#conversation' do
    xit 'Returns all messages'
  end

  describe '#write_message(message)' do
    xit 'Add new message to negotiation'
  end

  describe '#can_offer_deal?(id_negotiator)' do
    xit 'Return if negotiator can offer a deal'
  end

  describe '#offer_deal(id_negotiator)' do
    xit 'Offers a deal to other negotiator'
  end

  describe '#can_accept_deal?(id_negotiator)' do
    xit 'Return if negotiator can accept a deal'
  end

  describe '#accept_deal(id_negotiator)' do
    xit 'Acceps deal from other negotiatior'
  end

  describe '#join(id_negotiator)' do
    xit 'Negotiator joins negotiation'
  end

  describe '#leave(id_negotiator)' do
    xit 'Negotiator leaves negotiation'
  end
end