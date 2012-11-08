require 'spec_helper'

describe Negotiation do
  describe 'Relations' do
    it { should embed_many :proposals }
    it { should embed_many :messages }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:token_owner).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:token_state).of_type(Boolean) }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :token_owner }
    it { should validate_presence_of :token_state }
  end

  describe 'Factory' do
    let (:negotiation) { Fabricate(:negotiation) }
    specify { negotiation.should be_valid }
  end
end