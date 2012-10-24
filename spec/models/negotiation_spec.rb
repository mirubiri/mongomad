require 'spec_helper'

describe Negotiation do
  it { should belong_to :negotiation_box }
  it { should embed_one :proposal_box }
  it { should embed_one :conversation }


  describe 'Factory' do
    let (:negotiation) { Fabricate(:negotiation) }
    specify { negotiation.should be_valid }
  end
end
