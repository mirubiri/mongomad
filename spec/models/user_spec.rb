require 'spec_helper'

describe User do
  # let(:user) { Fabricate.build(:user) }

  describe 'Relations' do
    it { should have_many :requests }
    it { should have_many(:sent_offers).of_type(Offer) }
    it { should have_many(:received_offers).of_type(Offer) }
    it { should have_and_belong_to_many :negotiations }
    it { should have_and_belong_to_many :deals }
    it { should embed_one :profile }
    it { should embed_many :things }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  #   it { should accept_nested_attributes_for :profile }
  #   it { should have_field(:name).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :profile }
  #   it { should validate_presence_of :name }
  end

  # describe 'Factories' do
  #   specify { expect(user).to be_valid }
  #   specify { expect(user.save).to eq true }
  # end
end
