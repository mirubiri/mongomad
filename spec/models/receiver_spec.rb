require 'spec_helper'

describe Receiver do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_receiver }
    it { should embed_many :products }
  end

  describe 'Factory' do
    let (:receiver) { Fabricate(:receiver) }
    specify { receiver.should be_valid }
  end
end