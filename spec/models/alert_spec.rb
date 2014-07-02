require 'rails_helper'

describe Alert do

  it { is_expected.to include_module Ownership }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :text }
  it { is_expected.to have_field(:location).of_type(Array) }

  # Validations

  # Factories
end
