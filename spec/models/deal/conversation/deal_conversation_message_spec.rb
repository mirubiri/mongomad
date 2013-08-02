require 'spec_helper'

describe Deal::Conversation::Message do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:conversation) { deal.conversation }
  let(:message) { conversation.messages.last }

  describe 'Includes' do
    xit 'include ImageManager::ImageHolder'
  end

  describe 'Relations' do
    it { should be_embedded_in(:conversation).of_type(Deal::Conversation) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_denormalized_fields(:image_fingerprint).from('user.profile') }
    it { should have_denormalized_fields(:name).from('user') }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :conversation }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :text }
    it { should validate_length_of(:text).within(1..160) }
  end

  describe 'Factories' do
    specify { expect(message).to be_valid }

    it 'creates one deal' do
      expect { message.save }.to change{ Deal.count }.by(1)
    end
  end

  describe '#user' do
    subject { message.user }

    it { should be_instance_of(User) }

    it 'returns user who posted current message' do
      expect(subject.id).to eq message.user_id
    end
  end
end
