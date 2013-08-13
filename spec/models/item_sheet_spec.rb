require 'spec_helper'

describe ItemSheet do
  let(:sheet) { Fabricate.build(:item_sheet) }

  xit 'should have one main image & two secondary images'
  xit 'should have user_id'
  xit 'should have thing_id'

  # Relations
  it { should be_embedded_in :item_sheet_container }

  # Attributes
  it { should have_field :name }
  it { should have_field :description }

  # Validations
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }

  # Factories
  specify { expect( Fabricate.build(:item_sheet, container: :item) ).to be_valid }
  specify { expect( Fabricate.build(:item_sheet, container: :product)).to be_valid }
end
