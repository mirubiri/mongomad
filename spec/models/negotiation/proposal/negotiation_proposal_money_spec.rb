require 'spec_helper'

describe Negotiation::Proposal::Money do
  let(:money) do
    Fabricate.build(:negotiation_proposal_money, proposal:Fabricate.build(:negotiation_proposal, negotiation:Fabricate.build(:negotiation)))
  end

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Negotiation::Proposal) }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:quantity).of_type(Integer) }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposal }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than: 0) }
  end

  describe 'Factories' do
    specify { expect(money.valid?).to be_true }
  end
end
