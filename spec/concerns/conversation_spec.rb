require 'spec_helper'

class TestConversation
  include Mongoid::Document
  include Conversation
end

describe 'Conversation' do
  subject { TestConversation }

  it { is_expected.to be < Conversation }

  it { is_expected.to embed_many(:messages).of_type(Message) }
end
