require 'spec_helper'

describe Request do
  let(:request) do
    Fabricate.build(:request)
  end

  describe 'Relations' do
    it { should belong_to(:user) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should_not have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:user_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_field(:image).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should_not validate_presence_of :user_id }
    it { should validate_presence_of :user_name }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(request.valid?).to be_true }
    it 'Creates one request' do
      expect { request.save }.to change{ Request.count}.by(1)
    end
    it 'Creates one user' do
      expect { request.save }.to change{ User.count }.by(1)
    end
  end

  describe '#save' do
    it 'Uploads an image' do
      request.save
      File.exist?(File.new(request.image.path)).should be_true
    end
  end
end
