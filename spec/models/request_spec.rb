require 'spec_helper'

describe Request do
  # Variables
  let(:request) { Fabricate.build(:request) }

  # Relations
  it { should belong_to :user }
  it { should embed_one(:user_sheet).of_type(UserSheet) }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :text }
  
  # Validations
  it { should validate_presence_of :user }
  it { should_not have_autosave_on(:user) }
  it { should validate_presence_of :user_sheet }
  it { should validate_length_of(:text).within(1..160) }

  # Factories
  specify { expect(Fabricate.build(:request)).to be_valid }
end
