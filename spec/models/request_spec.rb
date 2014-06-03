require 'rails_helper'

describe Request, :type => :model do
  # Variables
  let(:request) { Fabricate.build(:request) }

  it { expect(Request).to be < Ownership }

  # Relations

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :text }


  # Validations

  # Checks

  # Methods

  # Factories
end
