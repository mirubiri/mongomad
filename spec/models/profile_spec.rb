##Modules
require 'spec_helper'

describe Profile do
  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_fields(:name,
                            :surname,
                            :nickname,
                            :password,
                            :sex,
                            :country,
                            :email,
                            :delivery_address,
                            :phone_number,
                            :website)
                            .of_type(String) }
    it { should have_fields(:birth_date).of_type(Date) }
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of :user }
    #Attributes
    it { should validate_presence_of :name }
    it { should validate_presence_of :surname }
    it { should validate_presence_of :nickname }
    it { should validate_presence_of :password }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :country }
    it { should validate_presence_of :email }
    it { should validate_presence_of :birth_date }
  end


  describe 'Factory' do
    let (:profile) { Fabricate.build(:profile) }
    specify { profile.should be_valid }
  end
end