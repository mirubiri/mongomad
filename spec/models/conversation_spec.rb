require 'spec_helper'

describe Conversation do
  it { should be_embedded_in :polymorphic_conversation }
  it { should embed_many :messages }
end
