require 'rails_helper'

describe Negotiation do

  specify { expect(Negotiation).to be < Proposable }
  specify { expect(Negotiation).to be < Conversation }

  it { is_expected.to embed_many :messages }

  # Attributes
  it { is_expected.to be_timestamped_document }
end
