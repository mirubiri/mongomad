require 'rails_helper'

describe Offer do

  specify { expect(Offer).to be < Proposable }

  # Relations

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :message }
end
