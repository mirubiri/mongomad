#Modules
require 'spec_helper'

describe Negotiation do
  describe 'Relations' do
    it { should embed_many :proposals }
    it { should embed_many :messages }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:token_owner).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:token_state).of_type(String) }
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of(:proposals) }
    it { should validate_presence_of(:messages) }
    #Attributes
    it { should validate_presence_of(:token_owner) }
    it { should validate_presence_of(:token_state) }
  end

  #Behaviour
  describe 'Factory' do
    let (:negotiation) { Fabricate(:negotiation) }
    specify { negotiation.should be_valid }
  end
end