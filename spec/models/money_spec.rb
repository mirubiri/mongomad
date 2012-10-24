require 'spec_helper'

describe Money do
  describe 'Relations' do
    it { should be_embedded_in :offer }
  end

  describe 'Attributes' do
    it { should have_field(:money_owner).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:quantity).of_type(BigDecimal) }
  end

  describe 'Validations' do
    it { should validate_presence_of :money_owner }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(greater_than:0, nil:false)}
  end

  describe 'Factory' do
    let (:money) { Fabricate.build(:money) }
    specify { money.should be_valid }
  end


end
