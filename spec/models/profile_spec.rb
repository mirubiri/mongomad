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
  it { should_not validate_presence_of :user }
  it { should validate_presence_of :language }
  it { should validate_presence_of :location }
  it { should validate_length_of(:first_name).within(1..20) }
  it { should validate_length_of(:last_name).within(1..20) }

  # Factories
  specify { expect(Fabricate.build(:profile)).to be_valid }
end
