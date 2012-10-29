#Modules
require 'spec_helper'

describe User do

  #Relations
  describe 'Relations' do
    it { should embed_one(:profile) }
    it { should embed_many(:things) }
    it { should have_and_belong_to_many(:offer_inbox).of_type(Offer).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:offer_outbox).of_type(Offer).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:negotiations).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:deals).as_inverse_of(nil) }
  end

  #Attributes
  describe 'Attributes' do
    pending("TODO: Attributes")
  end

  #Validations
  describe 'Validations' do
    pending("TODO: Validations")
  end

  #Behaviour
  describe 'Factory' do
    let (:user) { Fabricate(:user) }
    specify { user.should be_valid }
  end

end
