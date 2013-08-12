require 'spec_helper'

describe ItemSheet do
  let(:sheet) { Fabricate.build(:item_sheet) }

  xit 'should have one main image & two secondary images'


  # Relations
  it { should be_embedded_in :sheet_container }

  # Attributes
  it { should have_fields :name,:description }

  # Validations
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }

  # Factories
  specify { expect( Fabricate.build(:item_sheet) ).to be_valid }
end
