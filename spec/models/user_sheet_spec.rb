require 'spec_helper'

describe UserSheet do
  xit 'should have field user_id BSON'
  xit 'should have an user photo'
  xit 'should have a location reference'

  # Relations
  it { should be_embedded_in :user_sheet_container }

  # Attributes
  it { should have_fields :nick,:first_name,:last_name }

  # Validations
  it { should validate_presence_of :nick }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  # Factories
  specify { expect(Fabricate.build(:user_sheet, container: :offer)).to be_valid }
  specify { expect(Fabricate.build(:user_sheet, container: :negotiation)).to be_valid }
  specify { expect(Fabricate.build(:user_sheet, container: :dea)).to be_valid }
end
