require 'rails_helper'

describe Profile do
  # Modules
  it { is_expected.to include_module Attachment::Images }

  # Relations
  it { is_expected.to be_embedded_in :user }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_fields :first_name, :last_name, :gender, :language }
  it { is_expected.to have_field(:birth_date).of_type(Date) }
  it { is_expected.to have_field(:location).of_type(Array) }

  # Factories
  specify { expect(Fabricate.build(:profile)).to be_valid }
end
