#Modules
require 'spec_helper'

describe Money do

  #Relations
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_money }
  end

  #Attributes
  describe 'Attributes' do
    it { should have_field(:money_owner).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:quantity).of_type(BigDecimal) }
  end

  #Validations
  describe 'Validations' do
    #Attributes
    pending("REVISAR: Attributes Validations")
    it { should validate_presence_of :money_owner }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(greater_than:0, nil:false)}
  end

  #Behaviour
  describe 'Factory' do
    let (:money) { Fabricate(:money) }
    specify { money.should be_valid }
  end

end
