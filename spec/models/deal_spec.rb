require 'spec_helper'

describe Deal do
  let(:deal) { Fabricate(:deal) }

  describe 'Relations' do
    it { should embed_one :agreement }
    it { should embed_many :messages }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :agreement }
  end

  describe 'Factory' do
    specify { deal.should be_valid }
    specify { deal.save.should be_true }
  end

  describe '#conversation' do
    xit 'Returns all messages'
  end

  describe '#write_message(message)' do
    xit 'Add new message to deal'
  end

  describe '#agreement' do
    xit 'Returns the agreement'
  end

  describe '#other_id(id_dealer)' do
    xit 'Returns the id of the other dealer'
  end

  describe '#user_dealer' do
    xit 'Returns user who composes the offer'
  end

  describe '#user_dealer_id' do
    xit 'Returns the id of the user who composes the offer'
  end
end