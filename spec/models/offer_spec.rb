require 'rails_helper'

describe Offer, :type => :model do

  specify { expect(Offer).to be < Proposable }

  # Relations
  it { is_expected.to belong_to :negotiation }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :message }
end
