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
  pending 'should have the city name'

  # Validations
  it { should_not validate_presence_of :user }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :language }
  it { should validate_presence_of :location }

  # Factories
  specify { expect(Fabricate.build(:profile)).to be_valid }
end
