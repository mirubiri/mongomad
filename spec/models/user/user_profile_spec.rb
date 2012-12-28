require 'spec_helper'

describe User::Profile do
  let(:profile) { Fabricate.build(:user).profile }

  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:surname).of_type(String) }
    it { should have_field(:nickname).of_type(String) }
    it { should have_field(:sex).of_type(String) }
    it { should have_field(:country).of_type(String) }
    it { should have_field(:delivery_address).of_type(String) }
    it { should have_field(:phone_number).of_type(String) }
    it { should have_field(:website).of_type(String) }
    it { should have_field(:birth_date).of_type(Date) }
    # TODO: ¿Validar campo 'image' (Paperclip)?
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :name }
    it { should validate_presence_of :surname }
    it { should validate_presence_of :nickname }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :country }
    it { should validate_presence_of :birth_date }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(profile.valid?).to be_true }
  end
end
