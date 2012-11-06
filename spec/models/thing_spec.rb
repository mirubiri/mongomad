#Modules
require 'spec_helper'

describe Thing do
  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should have_fields(:name,
                            :description)
                            .of_type(String) }
    it { should have_field(:stock).of_type(Integer).with_default_value_of(1) }
  end

  describe 'Validations' do
    #Attributes
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :stock }
    it { should validate_numericality_of(:stock).to_allow(nil: false,
                                                          only_integer: true,
                                                          greater_than_or_equal_to: 0) }
  end

  #Behaviour
  describe 'Factory' do
    let (:thing) { Fabricate.build(:thing) }
    specify { thing.should be_valid }
  end
end