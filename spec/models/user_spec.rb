require 'spec_helper'

describe User do
  let(:user) { Fabricate.build(:user) }
  after(:each) { user && user.destroy }

  describe 'Relations' do
    it { should embed_one(:profile).of_type(User::Profile) }
    it { should embed_many(:things).of_type(User::Thing) }
    it { should have_and_belong_to_many(:requests).of_type(Request).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:sent_offers).of_type(Offer).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:received_offers).of_type(Offer).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:negotiations).of_type(Negotiation).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:deals).of_type(Deal).as_inverse_of(nil) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :profile }
  end

  describe 'Factories' do
    #las factorias y metodos hay que revisarlos
    specify { user.should be_valid }
    specify { user.save.should be_true }
  end
end