require 'spec_helper'

class TestConversation
  include Mongoid::Document
  include Conversation
end

describe 'Conversation' do
  subject { TestConversation }

  it { should < Conversation }

  it { should embed_many(:messages).of_type(Message) }
end
