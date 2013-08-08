require 'spec_helper'

describe Sheet do
  let(:sheet) { Fabricate.build(:sheet) }

  xit ' should have two secondary images'
  xit ' should have one main image '

  # Relations
  it { should be_embedded_in :sheet_container }

  # Attributes
  it { should have_fields :name,:description }

  # Validations
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }

  # Factories
  specify { expect( Fabricate.build(:sheet) ).to be_valid }
end
