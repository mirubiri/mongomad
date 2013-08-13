require 'spec_helper'

describe Profile do
  # Relations
  it { should be_embedded_in :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :gender }
  it { should have_field :language }
  it { should have_field(:birth_date).of_type(Date) }

  # Validations
  it { should validate_presence_of :language }

  # Factories
  specify { expect(Fabricate.build(:profile)).to be_valid }
end
