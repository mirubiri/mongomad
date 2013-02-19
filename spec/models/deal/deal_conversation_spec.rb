require 'spec_helper'

describe Deal::Conversation do
  let(:conversation) do
    Fabricate.build(:deal).conversation
  end

  describe 'Relations' do
    it { should be_embedded_in :deal }
    it { should embed_many(:messages).of_type(Deal::Conversation::Message) }
  end

  describe 'Attributes' do
    it { should have_field(:starter_signer_image_name).of_type(Object) }
    it { should have_field(:follower_signer_image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :deal }
    it { should validate_presence_of :messages }
    it { should validate_presence_of :starter_signer_image_name }
    it { should validate_presence_of :follower_signer_image_name }
  end

  describe 'Factories' do
    specify { expect(conversation.valid?).to eq true }

    it 'creates one negotiation' do
      expect { conversation.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has both images' do
      conversation.save
      File.exist?(File.new(conversation.starter_signer_image_name.path)).should eq true
      File.exist?(File.new(conversation.follower_signer_image.path)).should eq true
    end
  end

  describe '#self_update' do
    xit 'updates itself'
  end
end
