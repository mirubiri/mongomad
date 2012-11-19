require 'spec_helper'

describe Composer do
  let(:composer) { Fabricate.build(:composer) }

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_composer }
    it { should embed_many :products }
    it { should embed_one :photo }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :polymorphic_composer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :photo }

  end

  describe 'Factory' do
    specify { composer.should be_valid }
    specify { composer.save.should be_true }
    it 'photo must be saved on disk' do
      composer.save
      expect(File.exists?(composer.photo.file.path)).to be_true
    end
  end

  describe '#destroy' do
    it 'deletes photo files from disk' do
      file_path=composer.photo.file.path
      composer.save
      composer.destroy
      expect(File.exists?(file_path)).to be_false
    end
  end
end