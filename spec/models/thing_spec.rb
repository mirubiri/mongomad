require 'spec_helper'

describe Thing do
  let(:thing) { Fabricate.build(:thing) }

  # Relations
  it { should be_embedded_in :user }
  it { should embed_one :sheet }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:stock).of_type(Integer) }

  # Validations
  it { should_not validate_presence_of :user }
  it { should validate_presence_of :sheet }
  it { should validate_presence_of :stock }
  it { should validate_numericality_of(:stock).to_allow(nil: false,
    only_integer: true,
    greater_than_or_equal_to: 0) }

  # Factories
  specify { expect( Fabricate.build(:thing) ).to be_valid }
end
