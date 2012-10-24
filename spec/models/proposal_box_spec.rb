require 'spec_helper'

describe ProposalBox do
  it { should be_embedded_in :negotiation }
  it { should embed_many :proposals }
end
