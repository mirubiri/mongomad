require 'spec_helper'

describe Proposal do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_proposal }
  end

  describe 'Factory' do
    let (:proposal) { Fabricate(:proposal) }
    specify { proposal.should be_valid }
  end
end
