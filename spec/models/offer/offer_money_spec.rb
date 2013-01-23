require 'spec_helper'

describe Offer::Money do
  let(:money) do
    Fabricate.build(:offer).money
  end

  describe 'Relations' do
    it { should be_embedded_in :offer }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:quantity).of_type(Integer).with_default_value_of(0) }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :offer }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(money.valid?).to be_true }
    it 'Creates one offer' do
      expect { money.save }.to change{ Offer.count}.by(1)
    end
  end
end
