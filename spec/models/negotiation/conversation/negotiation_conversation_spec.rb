require 'spec_helper'

describe Negotiation::Conversation do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:conversation) { negotiation.conversation }

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
    it { should embed_many(:messages).of_type(Negotiation::Conversation::Message) }
  end

  describe 'Attributes' do
    it { should accept_nested_attributes_for :messages }
  end

  describe 'Validations' do
   it { should validate_presence_of :negotiation }
   it { should validate_presence_of :messages }
  end

  describe 'Factories' do
    specify { expect(conversation).to be_valid }

    it 'creates one negotiation' do
      expect { conversation.save }.to change{ Negotiation.count }.by(1)
    end
  end
end
