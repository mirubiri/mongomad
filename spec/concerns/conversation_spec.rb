require 'spec_helper'

class TestConversation
  include Mongoid::Document
  include Conversation
end

describe 'Conversation' do
  subject { TestConversation }

  specify { expect(TestConversation).to be < Conversation }

  it { should embed_many(:messages).of_type(Message) }
end
