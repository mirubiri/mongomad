require 'rails_helper'

describe Negotiation, :type => :model do

  specify { expect(Negotiation).to be < Proposable }
  specify { expect(Negotiation).to be < Conversation }

  # Relations
  it { is_expected.to have_one :offer }
  it { is_expected.to embed_many :messages }

  # Attributes
  it { is_expected.to be_timestamped_document }
end
