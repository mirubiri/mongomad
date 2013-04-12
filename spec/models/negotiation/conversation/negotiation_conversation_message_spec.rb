require 'spec_helper'

describe Negotiation::Conversation::Message do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:conversation) { negotiation.conversation }
  let(:message) { conversation.messages.last }

  describe 'Relations' do
    it { should be_embedded_in(:conversation).of_type(Negotiation::Conversation) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:nick).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_field(:image_url).of_type(String) }
    it { should have_denormalized_fields(:nick, :image_url).from('user.profile') }
  end

  describe 'Validations' do
    it { should validate_presence_of :conversation }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :nick }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image_url }
    it { should validate_length_of(:text).within(1..160) }
  end

  describe 'Factories' do
    specify { expect(message).to be_valid }

    it 'creates one negotiation' do
      expect { message.save }.to change{ Negotiation.count }.by(1)
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
