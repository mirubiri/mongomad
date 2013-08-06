require 'spec_helper'

describe Deal::Agreement::Conversation do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:agreement) { deal.agreement }
  let(:conversation) { agreement.conversation }

  describe 'Relations' do
    it { should be_embedded_in(:agreement).of_type(Deal::Agreement) }
    it { should embed_many(:messages).of_type(Deal::Agreement::Conversation::Message) }
  end

  describe 'Attributes' do
    it { should accept_nested_attributes_for :messages }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :agreement }
    it { should validate_presence_of :messages }
  end

  describe 'Factories' do
    specify { expect(conversation).to be_valid }

    it 'creates one deal' do
      expect { conversation.save }.to change{ Deal.count }.by(1)
    end
  end
end
