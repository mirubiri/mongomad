require 'spec_helper'

describe Negotiation do
  #let(:negotiation) { Fabricate.build(:negotiation) }
  #after(:each) { negotiation && negotiation.destroy }

  describe 'Relations' do
    it { should embed_many(:offers).of_type(Negotiation::Offer) }
    it { should embed_many(:messages).of_type(Negotiation::Message) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:token_owner_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:token_state).of_type(Boolean) }
  end

  describe 'Validations' do
    it { should validate_presence_of :offers }
    it { should validate_presence_of :messages }
    it { should validate_presence_of :token_owner_id }
    it { should validate_presence_of :token_state }
  end

=begin
  describe 'Factories' do
    specify { negotiation.should be_valid }
    specify { negotiation.save.should be_true }
  end
=end
end