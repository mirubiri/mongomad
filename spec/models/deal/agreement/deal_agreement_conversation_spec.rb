require 'spec_helper'

describe Deal::Agreement::Conversation do
  let(:conversation) do
    Fabricate.build(:deal).agreement.conversation
  end

  describe 'Relations' do
    it { should be_embedded_in(:agreement).of_type(Deal::Agreement) }
    it { should embed_many(:messages).of_type(Deal::Agreement::Conversation::Message) }
  end

  describe 'Attributes' do
    xit { should have_field(:starter_signer_image_name).of_type(Object) }
    xit { should have_field(:follower_signer_image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :agreement }
    it { should validate_presence_of :messages }
    xit { should validate_presence_of :starter_signer_image_name }
    xit { should validate_presence_of :follower_signer_image_name }
  end

  describe 'Factories' do
    specify { expect(conversation).to be_valid }

    it 'creates one negotiation' do
      expect { conversation.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe 'On save' do
    xit 'has both images' do
      conversation.save
      expect(File.exist? conversation.starter_signer_image_name.path)).to eq true
      expect(File.exist? conversation.follower_signer_image.path)).to eq true
    end
  end

  describe '#self_update' do
    xit 'updates itself'
  end
end
