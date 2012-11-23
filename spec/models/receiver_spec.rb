require 'spec_helper'

describe Receiver do
  let(:receiver) { Fabricate.build(:receiver) }
  after(:each) { receiver && receiver.receiver_parent.destroy }

  describe 'Relations' do
    it { should be_embedded_in :receiver_parent }
    it { should embed_many :products }
    it { should embed_one :photo}

  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :receiver_parent }
    it { should validate_presence_of :products }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :photo }
  end

  describe 'Factories' do
    specify { receiver.should be_valid }
    specify { receiver.save.should be_true }
    it 'photo must be saved on disk' do
      receiver.save
      expect(File.exists?(receiver.photo.file.path)).to be_true
    end
  end

  describe '#destroy' do
    it 'deletes photo files from disk' do
      file_path=receiver.photo.file.path
      receiver.save
      receiver.destroy
      expect(File.exists?(file_path)).to be_false
    end
  end
end