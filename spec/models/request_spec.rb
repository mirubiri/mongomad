require 'spec_helper'

describe Request do
  # Variables
  let(:request) { Fabricate.build(:request) }

  it { expect(Request).to be < Ownership }

  # Relations

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :text }


  # Validations

  # Checks

  # Methods

  # Factories
end
