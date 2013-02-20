require 'spec_helper'

describe Negotiation::Conversation do
  let(:conversation) do
    Fabricate.build(:negotiation).conversation
  end

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
    it { should embed_many(:messages).of_type(Negotiation::Conversation::Message) }
  end

  describe 'Attributes' do
  end

  describe 'Validations' do
   it { should validate_presence_of :negotiation }
  end
end
