require 'spec_helper'

describe Request do
  let(:request) { Fabricate.build(:request) }

  # Relations
  it { should belong_to :user }
  it { should embed_one(:sheet).of_type(UserSheet) }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:text) }

  # Validations
  it { should validate_presence_of :user }
  it { should validate_presence_of :sheet }
  it { should validate_presence_of :text }
  it { should validate_length_of(:text).within(1..160) }

  # Factories
  specify { expect( Fabricate.build(:request) ).to be_valid }
end
