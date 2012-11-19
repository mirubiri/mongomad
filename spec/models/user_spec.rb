require 'spec_helper'

describe User do
  let(:user) { Fabricate.build(:user) }
  describe 'Relations' do
    it { should embed_one :profile }
    it { should embed_many :things }
    it { should have_and_belong_to_many(:requests).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:sent_offers).of_type(Offer).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:received_offers).of_type(Offer).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:negotiations).as_inverse_of(nil) }
    it { should have_and_belong_to_many(:deals).as_inverse_of(nil) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :profile }
  end

  describe 'Factories' do
    specify { expect(user.valid?).to be_true }
    specify { expect(user.save).to be_true,"A ver que tenemos #{user.errors.messages}" }
  end
end