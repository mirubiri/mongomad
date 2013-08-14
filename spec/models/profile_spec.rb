require 'spec_helper'

describe Profile do
  xit 'should have an user photo'
  xit 'should have the city name or coordinates where user live'

  # Relations
  it { should be_embedded_in :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :first_name }
  it { should have_field :last_name}
  it { should have_field :gender }
  it { should have_field :language }
  it { should have_field(:birth_date).of_type(Date) }

  # Validations
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :language }

  # Factories
  specify { expect(Fabricate.build(:profile)).to be_valid }
end
