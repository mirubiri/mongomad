require 'spec_helper'

describe Negotiation::Offer::Money do
  #let(:money) { Fabricate.build(:money) }
  #after(:each) { money && money.polymorphic_money.destroy }

  describe 'Relations' do
    it { should be_embedded_in(:offer).of_type(Negotiation::Offer) }
  end

  describe 'Attributes' do
    it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:quantity).of_type(Integer) }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than: 0) }
  end

=begin
  describe 'Factories' do
    specify { money.should be_valid }
    specify { money.save.should be_true }
  end
=end
end