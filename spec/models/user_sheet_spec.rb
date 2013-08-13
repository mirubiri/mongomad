require 'spec_helper'

describe UserSheet do
  let (:sheet) { Fabricate.build(:user_sheet) }

  xit 'should have an user photo'
  xit 'should have the city name or coordinates where user live'

  # Relations
  it { should be_embedded_in :user_sheet_container }

  # Attributes
  it { should have_field :nick }
  it { should have_field :first_name }
  it { should have_field :last_name}

  # Validations
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :nick }

  # Factories
  specify { expect(Fabricate.build(:user_sheet, container: :user)).to be_valid }
end
