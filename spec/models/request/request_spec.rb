require 'spec_helper'

describe Request do
  let(:user) { Fabricate(:user) }
  let(:request) { Fabricate.build(:request, user:user) }

  describe 'Relations' do
    it { should belong_to(:user) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:nickname).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
    it { should have_denormalized_fields(:nickname, :image_name).from('user.profile') }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :nickname }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image_name }
    it { should validate_length_of(:text).within(1..160) }
  end

  describe 'Factories' do
    specify { expect(request).to be_valid }
    specify { expect(request.save).to eq true }

    it 'creates one user' do
      expect { request.save }.to change{ User.count }.by(1)
    end
  end

  describe 'after_save' do
    it 'has an image' do
      request.save
      expect(File.exist? request.image.path).to be true
    end
  end
end
