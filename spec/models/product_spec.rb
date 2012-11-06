#Modules
require 'spec_helper'

describe Product do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_product }
  end

  describe 'Attributes' do
    it { should have_field(:thind_id).of_type(Moped::BSON::ObjectId) }
    it { should have_fields(:name,
                            :description)
                            .of_type(String) }
    it { should have_field(:quantity).of_type(Integer).with_default_value_of(1) }
  end

  describe 'Validations' do
    #Attributes
    it { should validate_presence_of :thind_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  #Behaviour
  describe 'Factory' do
   let (:product) { Fabricate(:product) }
    specify { product.should be_valid }
  end
end