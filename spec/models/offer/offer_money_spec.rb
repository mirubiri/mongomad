require 'spec_helper'

describe Offer::Money do
  let(:offer) { Fabricate.build(:offer) }
  let(:money) { offer.money }
  let(:money_params) { params_for_offer(offer)[:money]}

  describe 'Relations' do
    it { should be_embedded_in :offer }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:quantity).of_type(Integer) }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(money.valid?).to eq true }

    it 'creates one offer' do
      expect { money.save }.to change{ Offer.count }.by(1)
    end
  end

  describe '#alter_contents' do
    it 'set current values to the given params' do
      new_money=Fabricate.build(:offer_money)
      new_money.alter_contents money_params
      expect(new_money).to be_like money
    end
  end
end
