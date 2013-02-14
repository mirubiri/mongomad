require 'spec_helper'

describe Deal::Agreement::Proposal::Money do
  let(:money) do
    Fabricate.build(:deal).agreement.proposals.last.money
  end

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
    specify { expect(money.valid?).to eq true, "Is not valid because #{money.errors}" }

    it 'Creates one deal' do
      expect { money.save }.to change{ Deal.count }.by(1)
    end
   end
end
