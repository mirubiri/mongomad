require 'spec_helper'

describe Item do
  xit 'should have one main image & two secondary images'
  xit 'should have user_id BSON'
  xit 'should have item_id BSON'

  # Relations
  it { should be_embedded_in :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :name,:description }
  it { should have_field(:stock).of_type(Integer) }

  # Validations
  it { should validate_presence_of :stock }
  it { should validate_numericality_of(:stock).to_allow(nil: false, only_integer: true, greater_than_or_equal_to: 0) }

  # Factories
  specify { expect(Fabricate.build(:item)).to be_valid }

  # Methods
  xit '#product(qty)'
end
