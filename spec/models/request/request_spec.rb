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
    it { should have_field(:user_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :user_name }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(request.valid?).to eq true, "Is not valid because #{request.errors}" }
    specify { expect(request.save).to eq true }

    it 'Creates one user' do
      expect { request.save }.to change{ User.count }.by(1)
    end
  end

  describe 'On save' do
    it 'Has an image' do
      request.save
      File.exist?(File.new(request.image.path)).should eq true
    end
  end

  describe '.generate(hash)' do
    xit 'Creates a new request with the given hash'
  end

  describe '#publish' do
    xit 'Saves the request'
  end

  describe '#modify(hash)' do
    xit 'Updates the request with the given hash'
  end

  describe '#unpublish' do
    xit 'Deletes the request'
  end
end
