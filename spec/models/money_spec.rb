require 'spec_helper'

describe Money do
  let(:money) { Fabricate.build(:money) }

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_money }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:quantity).of_type(Integer) }
  end

  describe 'Validations' do
    it { should validate_presence_of :polymorphic_money }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than: 0) }
  end

  describe 'Factories' do
    specify { money.should be_valid }
    specify { money.save.should be_true }
  end
end