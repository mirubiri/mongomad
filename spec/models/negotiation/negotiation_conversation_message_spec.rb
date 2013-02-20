require 'spec_helper'

describe Negotiation::Conversation::Message do
  let(:message) do
    Fabricate.build(:negotiation).conversation.first
  end

  describe 'Relations' do
    it { should be_embedded_in(:conversation).of_type(Negotiation::Conversation) }
  end

  describe 'Attributes' do
  end

  describe 'Validations' do
  end
end
