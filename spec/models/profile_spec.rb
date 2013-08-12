require 'spec_helper'

describe Profile do
  let(:profile) { Fabricate.build(:profile) }

  # Relations
  it { should be_embedded_in :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :gender, :language }
  it { should have_field(:birth_date).of_type(Date) }
  xit 'should have the city name or coordinates where user live'

  # Validations
  it { should validate_presence_of :language }

  # Factories
  specify { expect( Fabricate.build(:profile) ).to be_valid }
end
