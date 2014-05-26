require 'spec_helper'

describe Profile do
  # Modules
  it { should include_module Attachment::Images }

  # Relations
  it { should be_embedded_in :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :first_name, :last_name, :gender, :language }
  it { should have_field(:birth_date).of_type(Date) }
  it { should have_field(:location).of_type(Array) }

  # Validations

  # Factories
  specify { expect(Fabricate.build(:profile)).to be_valid }
end
