#Modules
require 'spec_helper'

describe Profile do

  describe 'Relations' do
    it { should be_embedded_in :user }
    it { should embed_one :photo }
  end

  describe 'Attributes' do
    it { should have_fields(:name,
                            :surname,
                            :nickname,
                            :password,
                            :country,
                            :flag_url,
                            :email,
                            :delivery_address,
                            :phone_number,
                            :website)
                            .of_type(String) }
    it { should have_fields(:birth_date,
                            :registration_date)
                            .of_type(DateTime) }
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of :photo }
    #Attributes
    it { should validate_presence_of :name }
    it { should validate_presence_of :surname }
    it { should validate_presence_of :nickname }
    it { should validate_presence_of :password }
    it { should validate_presence_of :country }
    it { should validate_presence_of :flag_url }
    it { should validate_presence_of :email }
    it { should validate_presence_of :birth_date }
    it { should validate_presence_of :registration_date }
  end

  #Behaviour
  describe 'Factory' do
    let (:profile) { Fabricate(:profile) }
    specify { profile.should be_valid }
  end

end