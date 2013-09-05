require 'spec_helper'

describe Product do

  xit 'should have one main image & two secondary images'
  xit 'should have user_id BSON'
  xit 'should have item_id BSON'

  # Relations
  it { should be_embedded_in :proposal }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :name,:description }
  it { should have_field(:quantity).of_type(Integer) }

  # Validations
  xit { should validate_presence_of :proposal }
  it { should validate_presence_of :quantity }
  it { should validate_numericality_of(:quantity).to_allow(nil: false, only_integer: true, greater_than_or_equal_to: 0) }

  # Methods
  xit '#product(qty)'

  # Factories
  specify { expect(Fabricate.build(:product)).to be_valid }
end
