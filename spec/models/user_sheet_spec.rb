require 'spec_helper'

describe UserSheet do
  let (:sheet) { Fabricate.build(:user_sheet) }

  # Relations
  it { should be_embedded_in :user_sheet_container }

  # Attributes
  it { should have_fields :nick, :first_name, :last_name}

  # Validations
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :nick }
  xit 'should have an user photo'

  # Fabricators
  specify { expect(Fabricate.build(:user_sheet, container: :user)).to be_valid }
end
