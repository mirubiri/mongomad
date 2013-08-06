require 'spec_helper'

describe User::Profile do
  let(:user) { Fabricate(:user) }
  let(:profile) { user.profile }

  describe 'Includes' do
    xit 'include ImageManager::ImageHolder'
  end

  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:first_name).of_type(String) }
    it { should have_field(:last_name).of_type(String) }
    it { should have_field(:gender).of_type(String) }
    xit 'guardar coordenadas de la ciudad'
    it { should have_field(:birth_date).of_type(Date) }
    it { should have_field(:language).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'Factories' do
    specify { expect(profile).to be_valid }

    it 'creates one user' do
      expect { profile.save }.to change{ User.count }.by(1)
    end
  end
end
