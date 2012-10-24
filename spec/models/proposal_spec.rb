require 'spec_helper'

describe Proposal do
  it { should be_embedded_in :proposal_box }

  describe 'Factory' do
    #let (:proposal) { Fabricate(:proposal) }
    #specify { proposal.should be_valid }
  end
end
