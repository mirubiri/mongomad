require 'spec_helper'

describe Profile do
  let(:profile) { Fabricate.build(:profile) }
  after(:each) { profile && profile.user.destroy }

  describe 'Relations' do
    it { should be_embedded_in :user }
    it { should embed_one :photo }
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
    it { should validate_presence_of :sex }
    it { should validate_presence_of :country }
    it { should validate_presence_of :birth_date }
    it { should validate_presence_of :website }
  end

  describe 'Factories' do
    specify { expect(profile.valid?).to be_true }
    specify { expect(profile.save).to be_true }
    it 'photo must be saved on disk' do
      profile.save
      expect(File.exists?(profile.photo.file.path)).to be_true
    end
  end

  describe '#destroy' do
    it 'deletes photo files from disk' do
      file_path=profile.photo.file.path
      profile.save
      profile.destroy
      expect(File.exists?(file_path)).to be_false
    end
  end
end