require 'spec_helper'

describe Deal::Agreeement::Conversation::Message do
  let(:message) do
    Fabricate.build(:deal).agreement.conversation.messages.last
  end

  describe 'Relations' do
    it { should be_embedded_in(:conversation).of_type(Deal::Agreeement::Conversation) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :conversation }
    it { should validate_presence_of :user_name }
    it { should validate_presence_of :text }
  end

  describe 'Factories' do
    specify { expect(message.valid?).to eq true }

    it 'creates one negotiation' do
      expect { message.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe '#self_update' do
    xit 'updates itself'
  end
end
