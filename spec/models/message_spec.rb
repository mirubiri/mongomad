require 'spec_helper'

describe Message do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_message }
  end

  describe 'Factory' do
    let (:message) { Fabricate(:message) }
    specify { message.should be_valid }
  end
end
