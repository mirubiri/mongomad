require 'spec_helper'

describe Deal::Conversation do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:conversation) { deal.conversation }

  describe 'Relations' do
    it { should be_embedded_in :deal }
    it { should embed_many(:messages).of_type(Deal::Conversation::Message) }
  end

  describe 'Attributes' do
    it { should accept_nested_attributes_for :messages }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :deal }
  end

  describe 'Factories' do
    specify { expect(conversation).to be_valid }

    it 'creates one deal' do
      expect { conversation.save }.to change{ Deal.count }.by(1)
    end
  end
end
