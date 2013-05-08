require 'spec_helper'

describe User::Profile do
  let(:user) { Fabricate(:user) }
  let(:profile) { user.profile }

  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:surname).of_type(String) }
    it { should have_field(:nick).of_type(String) }
    it { should have_field(:sex).of_type(String) }
    it { should have_field(:country).of_type(String) }
    it { should have_field(:delivery_address).of_type(String) }
    it { should have_field(:phone_number).of_type(String) }
    it { should have_field(:website).of_type(String) }
    it { should have_field(:birth_date).of_type(Date) }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :user }
    it { should validate_presence_of :name }
    it { should validate_presence_of :surname }
    it { should validate_presence_of :nick }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :country }
    it { should validate_presence_of :birth_date }
  end

  describe 'Factories' do
    specify { expect(profile).to be_valid }

    it 'creates one user' do
      expect { profile.save }.to change{ User.count }.by(1)
    end
  end
end
