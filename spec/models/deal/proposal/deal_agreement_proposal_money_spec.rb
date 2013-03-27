require 'spec_helper'

describe Deal::Agreement::Proposal::Money do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:agreement) { deal.agreement }
  let(:proposal) { agreement.proposals.last }
  let(:money) { proposal.money }

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Deal::Agreement::Proposal) }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:quantity).of_type(Integer) }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposal }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(money).to be_valid}

    it 'creates one deal' do
      expect { money.save }.to change{ Deal.count }.by(1)
    end
   end
end
