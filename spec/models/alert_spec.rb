require 'spec_helper'

describe Alert do
  
  it { should include_module Ownership }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :text }
  it { should have_field(:location).of_type(Array) }

  # Validations

  # Factories
end
