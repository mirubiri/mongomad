require 'spec_helper'

describe Negotiation do
  # Variables

  specify { expect(Negotiation).to be < Proposable }
  # Relations
  it { should have_one :offer }
  it { should embed_many :messages }

  # Attributes
  it { should be_timestamped_document }

  # Validations

  # Checks


  # Methods

  # Factories
end
