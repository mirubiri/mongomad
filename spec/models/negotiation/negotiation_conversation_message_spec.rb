require 'spec_helper'

describe Negotiation::Message do
  let(:message) do
    Fabricate.build(:negotiation).messages.last
  end

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :negotiation }
    it { should validate_presence_of :user_name }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(message.valid?).to eq true }

    it 'creates one negotiation' do
      expect { message.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      message.save
      File.exist?(File.new(message.image.path)).should eq true
    end
  end
end
