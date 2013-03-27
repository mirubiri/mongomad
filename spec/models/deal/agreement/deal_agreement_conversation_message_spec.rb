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
    it { should have_field(:text).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :conversation }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :text }
    it { should validate_length_of(:text).within(1..160) }
  end

  describe 'Factories' do
    specify { expect(message).to be_valid }

    it 'creates one deal' do
      expect { message.save }.to change{ Deal.count }.by(1)
    end
  end
end
