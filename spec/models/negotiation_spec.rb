require 'spec_helper'

describe Negotiation do

  specify { expect(Negotiation).to be < Proposable }
  specify { expect(Negotiation).to be < Conversation }

  # Relations
  it { should have_one :offer }
  it { should embed_many :messages }

  # Attributes
  it { should be_timestamped_document }
end
