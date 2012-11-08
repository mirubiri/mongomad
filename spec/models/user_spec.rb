#Modules
require 'spec_helper'

describe User do
  describe 'Relations' do
    it { should embed_one :profile }
    it { should embed_many :things }
    it { should embed_many :requests }
    it { should have_and_belong_to_many(:sent_offers).of_type(Offer).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:received_offers).of_type(Offer).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:negotiations).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:deals).as_inverse_of(nil) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of :profile }
  end

  #Behaviour
  #describe 'Factory' do
  #  let (:user) { Fabricate(:user) }
  #  specify { user.should be_valid }
  #end
end