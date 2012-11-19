require 'spec_helper'

describe Profile do
  let(:profile) { Fabricate.build(:profile) }

  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_fields(:name,
                            :surname,
                            :nickname,
                            :sex,
                            :country,
                            :delivery_address,
                            :phone_number,
                            :website)
                            .of_type(String) }
    it { should have_fields(:birth_date).of_type(Date) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :name }
    it { should validate_presence_of :surname }
    it { should validate_presence_of :nickname }
    it { should validate_presence_of :password }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :country }
    it { should validate_presence_of :email }
    it { should validate_presence_of :birth_date }
    it { should validate_presence_of :website }
  end

  describe 'Factory' do
    specify { expect {profile.valid?}.to be_true }
    specify { expect {profile.save}.to be_true }
  end
end