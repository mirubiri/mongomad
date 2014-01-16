require 'spec_helper'

describe Alert do
  xit 'should include a way of tracking new search results'

  # Relations
  it { should belong_to :user }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :text }
  it { should have_field(:location).of_type(Array) }

  # Validations
  it { should validate_presence_of :user }
  it { should_not have_autosave_on(:user) }
  it { should validate_length_of(:text).within(1..160) }
  it { should validate_presence_of :location }

  # Factories
  specify { expect(Fabricate.build(:alert)).to be_valid }
end
