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
    it { should have_field(:user_nickname).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_field(:image).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :user_nickname }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(request.valid?).to be_true }
    specify { expect(request.save).to be_true }
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
