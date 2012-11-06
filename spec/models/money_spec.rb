#Modules
require 'spec_helper'

describe Money do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_money }
  end

  describe 'Attributes' do
    it { should have_field(:owner).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:quantity).of_type(Integer) }
  end

  describe 'Validations' do
    #Attributes
    it { should validate_presence_of :owner }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than: 0) }
  end

  #Behaviour
  describe 'Factory' do
    let (:money) { Fabricate(:money) }
    specify { money.should be_valid }
  end
end