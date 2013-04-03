require 'spec_helper'

describe Deal::Agreement::Conversation::Message do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:agreement) { deal.agreement }
  let(:conversation) { agreement.conversation }
  let(:message) { conversation.messages.last }

  describe 'Relations' do
    it { should be_embedded_in(:conversation).of_type(Deal::Agreement::Conversation) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:nickname).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
    it { should have_denormalized_fields(:nickname, :image_name).from('user.profile') }
  end

  describe 'Validations' do
    it { should validate_presence_of :conversation }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :nickname }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image_name }
    it { should validate_length_of(:text).within(1..160) }
  end

  describe 'Factories' do
    specify { expect(message).to be_valid }

    it 'creates one deal' do
      expect { message.save }.to change{ Deal.count }.by(1)
    end
  end

  describe 'after_save' do
    it 'has an image' do
      message.save
      expect(File.exist? message.image.path).to eq true
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
